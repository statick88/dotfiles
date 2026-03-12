#!/usr/bin/env python3
import subprocess
import os
import time
import json
from utils import COLORS, sbar_set, get_state

def get_spotify_info():
    """Gets track info, state, and progress from Spotify."""
    try:
        is_running = subprocess.run(["pgrep", "-x", "Spotify"], capture_output=True).returncode == 0
        if not is_running: return None
        
        as_script = '''
        tell application "Spotify"
            if player state is playing then
                set player_state to "PLAYING"
            else
                set player_state to "PAUSED"
            end if
            set track_name to name of current track
            set artist_name to artist of current track
            set album_name to album of current track
            set track_duration to duration of current track
            set track_position to player position
            return player_state & "|" & artist_name & "|" & track_name & "|" & album_name & "|" & track_duration & "|" & track_position
        end tell
        '''
        res = subprocess.run(["osascript", "-e", as_script], capture_output=True, text=True).stdout.strip()
        if "|" in res:
            return res.split("|")
        return None
    except: return None

def make_progress_bar(current, total, size=20):
    """Creates a visual progress bar string."""
    try:
        current = float(current)
        total = float(total) / 1000 # Spotify returns duration in ms
        perc = max(0, min(1, current / total))
        filled = int(perc * size)
        return "█" * filled + "░" * (size - filled)
    except: return "░" * size

def main():
    name = os.environ.get("NAME", "spotify")
    sender = os.environ.get("SENDER", "")
    
    result = get_spotify_info()
    
    mode_state = get_state("modes", {"mode": "normal"})
    from modes import MODES
    mode_color = MODES.get(mode_state["mode"], MODES["normal"])["color"]
    icon_color = COLORS["GREEN"] if mode_state["mode"] == "normal" else mode_color

    if result:
        player_state, artist, track, album, duration, position = result
        
        # UI: If paused, hide everything as requested
        if player_state != "PLAYING" and sender not in ("mouse.entered", "mouse.exited"):
            sbar_set(name, {"icon.color": COLORS["DIM"], "label.drawing": "off", "popup.drawing": "off"})
            return

        if sender == "mouse.entered":
            sbar_set(name, {
                "popup.background.color": COLORS["ISLAND_BG"],
                "popup.background.border_color": COLORS["ISLAND_BORDER"],
                "popup.background.border_width": 2,
                "popup.background.corner_radius": 10,
                "popup.drawing": "on"
            })
            
            bar = make_progress_bar(position, duration)
            sbar_set("spotify.info.artist", {"label": f"Artista: {artist}", "drawing": "on"})
            sbar_set("spotify.info.track", {"label": f"Canción: {track}", "drawing": "on"})
            sbar_set("spotify.info.album", {"label": f"Álbum: {album}", "drawing": "on"})
            sbar_set("spotify.info.progress", {"label": f"{bar}", "drawing": "on"})
            sbar_set("spotify.info.prev", {"drawing": "on"})
            sbar_set("spotify.info.toggle", {
                "icon": "󰏤" if player_state == "PLAYING" else "󰐊",
                "drawing": "on"
            })
            sbar_set("spotify.info.next", {"drawing": "on"})
            return
        
        elif sender == "mouse.exited":
            sbar_set(name, {"popup.drawing": "off"})
            return

        # Update Bar (ONLY if playing)
        sbar_set(name, {
            "icon": "󰎆",
            "icon.color": icon_color,
            "label.drawing": "on",
            "label": f"{artist} - {track}",
            "label.color": icon_color
        })
        
        # Refresh popup contents if open
        bar = make_progress_bar(position, duration)
        sbar_set("spotify.info.progress", {"label": bar})
        sbar_set("spotify.info.toggle", {"icon": "󰏤" if player_state == "PLAYING" else "󰐊"})
        return

    # Spotify not running: CLEANUP
    sbar_set(name, {"icon.color": COLORS["DIM"], "label.drawing": "off", "popup.drawing": "off"})

if __name__ == "__main__":
    main()
