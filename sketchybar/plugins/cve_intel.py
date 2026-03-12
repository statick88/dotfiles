#!/usr/bin/env python3
import requests
import os
import time
from utils import COLORS, sbar_set, get_state, save_state

CACHE_FILE = "cve_cache"

def get_latest_cves():
    """Fetches latest critical CVEs from a public feed."""
    now_ts = time.time()
    state = get_state(CACHE_FILE, {"last_fetch": 0, "cves": []})
    
    # 1-hour cache
    if now_ts - state.get("last_fetch", 0) < 3600:
        return state.get("cves", [])

    try:
        # Using a public vulnerability feed (Circl.lu API is quite stable)
        url = "https://cve.circl.lu/api/last"
        res = requests.get(url, timeout=10)
        if res.status_code == 200:
            data = res.json()
            cves = []
            for item in data[:3]: # Take latest 3
                cves.append({
                    "id": item.get("id"),
                    "summary": item.get("summary", "No description")[:50] + "..."
                })
            state.update({"last_fetch": now_ts, "cves": cves})
            save_state(CACHE_FILE, state)
            return cves
    except:
        pass
    return state.get("cves", [])

def main():
    name = os.environ.get("NAME", "cve")
    sender = os.environ.get("SENDER", "")
    
    cves = get_latest_cves()

    if sender == "mouse.entered":
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        
        sbar_set("cve.header", {"label": "Últimas Vulnerabilidades", "drawing": "on"})
        
        for i in range(1, 4):
            item_name = f"cve.v{i}"
            if i <= len(cves):
                c = cves[i-1]
                sbar_set(item_name, {
                    "label": f"{c['id']}: {c['summary']}",
                    "drawing": "on",
                    "label.drawing": "on"
                })
            else:
                sbar_set(item_name, {"drawing": "off"})
        return
    
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Regular Bar Update
    # Label is hidden, just the icon
    sbar_set(name, {"icon.color": COLORS["ORANGE"] if cves else COLORS["DIM"]})

if __name__ == "__main__":
    main()
