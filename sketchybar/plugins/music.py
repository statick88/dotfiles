#!/usr/bin/env python3
import subprocess
import os
import sys
import time
from utils import COLORS, sbar_set

def stop_radio():
    try:
        # Import state without full radio module to avoid circularity
        import json
        STATE_FILE = os.path.expanduser("~/.config/sketchybar/state/radio.json")
        if os.path.exists(STATE_FILE):
            with open(STATE_FILE, "r") as f:
                state = json.load(f)
            if state.get("playing", False):
                state["playing"] = False
                with open(STATE_FILE, "w") as f:
                    json.dump(state, f)
                subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)
                subprocess.run(["sketchybar", "--trigger", "radio_update"], capture_output=True)
    except:
        pass

def get_spotify_info():
    is_running = subprocess.run(["pgrep", "-x", "Spotify"], capture_output=True).returncode == 0
    if not is_running: return None
    
    state = subprocess.run(["osascript", "-e", 'tell application "Spotify" to player state as string'], capture_output=True, text=True).stdout.strip()
    if state == "playing":
        track = subprocess.run(["osascript", "-e", 'tell application "Spotify" to name of current track'], capture_output=True, text=True).stdout.strip()
        artist = subprocess.run(["osascript", "-e", 'tell application "Spotify" to artist of current track'], capture_output=True, text=True).stdout.strip()
        return {"state": "playing", "label": f"{artist} - {track}", "color": COLORS["GREEN"]}
    elif state == "paused":
        return {"state": "paused", "label": "Spotify (Paused)", "color": COLORS["DIM"]}
    return None

def main():
    name = os.environ.get("NAME", "music")
    sender = os.environ.get("SENDER", "")
    click_arg = os.environ.get("CLICK_ARG", "")

    if sender == "mouse.clicked":
        if click_arg == "next": subprocess.run(["osascript", "-e", 'tell application "Spotify" to next track'])
        elif click_arg == "prev": subprocess.run(["osascript", "-e", 'tell application "Spotify" to previous track'])
        else: 
            subprocess.run(["osascript", "-e", 'tell application "Spotify" to playpause'])
            time.sleep(0.2)
            info = get_spotify_info()
            if info and info["state"] == "playing": stop_radio()
        time.sleep(0.1)

    info = get_spotify_info()
    if info:
        if info["state"] == "playing": stop_radio()
        sbar_set(name, {"label": info['label'], "icon.color": info['color'], "icon.drawing": "on", "label.drawing": "on"})
    else:
        sbar_set(name, {"label": "", "icon.color": COLORS["DIM"]})

if __name__ == "__main__":
    main()
