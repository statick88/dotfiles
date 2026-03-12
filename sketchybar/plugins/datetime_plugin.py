#!/usr/bin/env python3
import subprocess
import os
import re
import time
import locale
import json
from datetime import datetime
from utils import COLORS, sbar_set, get_state, save_state, notify

# 1. FORCE LOCALIZATION AND TIMEZONE (GMT-5)
os.environ["TZ"] = "America/Guayaquil"
if hasattr(time, 'tzset'):
    time.tzset()

try:
    locale.setlocale(locale.LC_TIME, 'es_EC.UTF-8')
except:
    try:
        locale.setlocale(locale.LC_TIME, 'es_ES.UTF-8')
    except:
        pass

CACHE_FILE = "calendar_cache"
LOCK_FILE = "/tmp/sketchybar_gcal_fetch.lock"

def clean_ansi(text):
    """Sanitizes text from ANSI escapes and corrupt fragments."""
    if not text: return ""
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    text = ansi_escape.sub('', text)
    # Remove known corruption fragment
    text = text.replace('(0x(B', '').strip()
    return text

def update_google_data_async():
    """Triggers gcalcli in the background without blocking the UI."""
    if os.path.exists(LOCK_FILE):
        if time.time() - os.path.getmtime(LOCK_FILE) < 120:
            return
    
    try:
        with open(LOCK_FILE, "w") as f:
            f.write(str(os.getpid()))
        
        subprocess.Popen(
            ["python3", os.path.abspath(__file__), "ACTION=fetch"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True
        )
    except: pass

def fetch_data():
    """Real fetch logic called only in the background."""
    try:
        res = subprocess.run(
            ["gcalcli", "agenda", "--nocolor", "--details", "all", "today", "tomorrow"],
            capture_output=True, text=True, timeout=25, env=os.environ
        )
        if res.returncode == 0:
            lines = res.stdout.splitlines()
            raw_events = []
            curr = None
            for line in lines:
                line_clean = clean_ansi(line)
                if not line_clean: continue
                
                time_match = re.search(r"(\d{1,2}:\d{2})", line_clean)
                if time_match and "Link:" not in line_clean and "Location:" not in line_clean:
                    time_str = time_match.group(1)
                    title = line_clean.split(time_str)[1].strip()
                    curr = {
                        "title": title, "time": time_str, 
                        "location": "No especificada", 
                        "url": "https://calendar.google.com/calendar/u/0/r"
                    }
                    raw_events.append(curr)
                elif curr:
                    if "Location:" in line_clean: curr["location"] = line_clean.split("Location:")[1].strip()
                    elif "Link:" in line_clean: curr["url"] = line_clean.split("Link:")[1].strip()

            # Deduplication
            seen = set()
            unique_events = []
            for ev in raw_events:
                key = f"{ev['title']}_{ev['time']}"
                if key not in seen:
                    seen.add(key)
                    unique_events.append(ev)
            
            save_state(CACHE_FILE, {"last_fetch": time.time(), "events": unique_events})
    finally:
        if os.path.exists(LOCK_FILE):
            os.remove(LOCK_FILE)

def update_popup_ui(state):
    """Updates the popup items instantly from cached data."""
    events = state.get("events", [])
    header = datetime.now().strftime("%A, %d de %B").capitalize()
    sbar_set("datetime.header", {"label": header, "drawing": "on"})
    
    displayed_count = 0
    # ONLY SHOW THE 13:00 EVENT AS REQUESTED
    target_event = next((ev for ev in events if ev.get("time") == "13:00" and "(0x(B" not in ev.get("title", "")), None)

    for i in range(5):
        ev_item, loc_item = f"datetime.event.{i}", f"datetime.loc.{i}"
        if i == 0 and target_event:
            sbar_set(ev_item, {
                "label": f"[{target_event['time']}] {target_event['title']}",
                "drawing": "on", "label.drawing": "on",
                "label.color": COLORS["WHITE"], "icon.color": COLORS["CYAN"],
                "click_script": f"open -a 'Google Chrome' '{target_event['url']}'"
            })
            if target_event['location'] and target_event['location'] != "No especificada":
                sbar_set(loc_item, {"label": target_event['location'], "drawing": "on", "label.drawing": "on"})
            else: sbar_set(loc_item, {"drawing": "off"})
            displayed_count = 1
        else:
            sbar_set(ev_item, {"drawing": "off"})
            sbar_set(loc_item, {"drawing": "off"})
    
    if displayed_count == 0:
        sbar_set("datetime.event.0", {"label": "Sin eventos hoy (13:00)", "drawing": "on", "label.drawing": "on"})

def main():
    name = os.environ.get("NAME", "datetime")
    sender = os.environ.get("SENDER", "")
    action = os.environ.get("ACTION", "")
    
    if action == "fetch":
        fetch_data()
        return

    # 1. READ CACHE (Instant)
    state = get_state(CACHE_FILE, {"last_fetch": 0, "events": []})
    now_ts = time.time()

    # 2. TRIGGER ASYNC UPDATE (Every 15 minutes / 900s)
    if now_ts - state.get("last_fetch", 0) > 900:
        update_google_data_async()

    # 3. UI HANDLING
    if sender == "mouse.entered":
        # Render from CACHE only - NO waiting for gcalcli
        update_popup_ui(state)
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        return
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return
    elif sender == "mouse.clicked":
        # Deep link if possible
        url = state["events"][0]["url"] if state.get("events") else "https://calendar.google.com"
        subprocess.run(["open", "-a", "Google Chrome", url])
        return

    # 4. REGULAR BAR UPDATE (Clock)
    now = datetime.now()
    sbar_set(name, {"label": now.strftime("%a %d %b %H:%M")})

if __name__ == "__main__":
    main()
