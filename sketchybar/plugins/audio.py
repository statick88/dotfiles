#!/usr/bin/env python3
import subprocess
import os
import sys
import shutil
import time
from utils import COLORS, sbar_set, get_state, save_state, notify

# Path for ffplay
FFPLAY_PATH = shutil.which("ffplay") or "/opt/homebrew/bin/ffplay"
USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# Stations Metadata (Validated 200 OK)
STATIONS = {
    "exa": {"name": "Radio Exa", "stream": "https://26573.live.streamtheworld.com/ECUADORAAC.aac"},
    "boqueron": {"name": "Radio Boqueron", "stream": "https://stream.hospedandosites.com.br:8038/stream"},
    "airelatino": {"name": "Aire Latino", "stream": "https://streaming.asilivehd.com/8134/stream?_ts=1773219430170"},
    "caravana": {"name": "Radio Caravana", "stream": "https://streamingecuador.net:9006/stream"},
}

STATION_ORDER = ["exa", "boqueron", "airelatino", "caravana"]

def get_radio_status():
    """Checks if ffplay is running in the background."""
    try:
        res = subprocess.run(["pgrep", "-f", "ffplay.*nodisp"], capture_output=True, text=True)
        return len(res.stdout.strip()) > 0
    except: return False

def play_radio(station_id):
    """Starts ffplay for the chosen station."""
    s = STATIONS.get(station_id)
    if not s: return
    
    # Stop existing radio processes
    subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)
    # Pause Spotify
    subprocess.run(["osascript", "-e", 'if application "Spotify" is running then tell application "Spotify" to pause'], capture_output=True)
    
    try:
        # Start new stream
        subprocess.Popen(
            [FFPLAY_PATH, "-nodisp", "-loglevel", "quiet", "-user_agent", USER_AGENT, "-autoexit", s["stream"]],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True
        )
        # Save state with the selected ID
        save_state("audio", {"current_id": station_id})
        notify("Radio", f"En vivo: {s['name']} 📻")
    except: pass

def update_bar(name):
    """Refreshes the Sketchybar item with current status."""
    is_playing = get_radio_status()
    # Retrieve last saved ID, default to 'exa'
    state = get_state("audio", {"current_id": "exa"})
    current_id = state.get("current_id", "exa")
    
    # Get metadata for the current ID
    station_data = STATIONS.get(current_id, STATIONS["exa"])
    current_name = station_data["name"]
    
    if is_playing:
        sbar_set(name, {
            "icon": "󰝚",
            "icon.color": COLORS["ORANGE"],
            "label": current_name,
            "label.drawing": "on"
        })
    else:
        sbar_set(name, {
            "icon": "󰝛",
            "icon.color": COLORS["DIM"],
            "label.drawing": "off"
        })

def main():
    name = os.environ.get("NAME", "radio")
    sender = os.environ.get("SENDER", "")
    action = os.environ.get("ACTION", "")
    station_id = os.environ.get("STATION_ID", "").strip()

    # --- ACTION HANDLERS ---
    if action == "stop_all":
        subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)
        sbar_set(name, {"popup.drawing": "off"})
        update_bar(name)
        return
    
    elif action == "play_id":
        play_radio(station_id)
        sbar_set(name, {"popup.drawing": "off"})
        update_bar(name)
        return
    
    elif action == "toggle_play":
        if get_radio_status():
            subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)
        else:
            state = get_state("audio", {"current_id": "exa"})
            play_radio(state["current_id"])
        update_bar(name)
        return
    
    elif action in ("next_station", "prev_station"):
        state = get_state("audio", {"current_id": "exa"})
        current_id = state.get("current_id", "exa")
        try: current_idx = STATION_ORDER.index(current_id)
        except: current_idx = 0
        step = 1 if action == "next_station" else -1
        new_idx = (current_idx + step) % len(STATION_ORDER)
        play_radio(STATION_ORDER[new_idx])
        update_bar(name)
        return

    # --- UI EVENT HANDLERS ---
    if sender == "mouse.entered":
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        return
    elif sender == "mouse.exited":
        # Keep popup management handled by Sketchybar or stay silent
        pass

    # --- REGULAR UPDATE ---
    update_bar(name)

if __name__ == "__main__":
    main()
