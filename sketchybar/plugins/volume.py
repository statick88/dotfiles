#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def toggle_mute():
    """Toggles mute state and pauses all audio sources when muting."""
    # Check current mute state before toggling
    res = subprocess.run(["osascript", "-e", "get volume settings"], capture_output=True, text=True)
    is_already_muted = "true" in res.stdout.split("output muted:")[1] if "output muted:" in res.stdout else False
    
    # Perform the toggle
    subprocess.run(["osascript", "-e", "set volume with output muted"], capture_output=True)
    
    # If we are NOW muting (it was false before), pause everything
    if not is_already_muted:
        # Pause Spotify
        subprocess.run(["osascript", "-e", 'if application "Spotify" is running then tell application "Spotify" to pause'], capture_output=True)
        # Stop Radio (ffplay)
        subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)

def main():
    name = os.environ.get("NAME", "volume")
    sender = os.environ.get("SENDER", "")
    
    if sender == "mouse.clicked":
        button = os.environ.get("BUTTON", "left")
        if button == "right":
            subprocess.run(["open", "x-apple.systempreferences:com.apple.preference.sound"])
        else:
            toggle_mute()

    # Read current state for UI update
    res = subprocess.run(["osascript", "-e", "get volume settings"], capture_output=True, text=True)
    out = res.stdout
    
    try:
        vol = int(out.split("output volume:")[1].split(",")[0])
        muted = "true" in out.split("output muted:")[1]
    except:
        vol, muted = 0, False

    if muted or vol == 0:
        icon, color = "󰝟", COLORS["RED"]
    elif vol < 33:
        icon, color = "󰕿", COLORS["CYAN"]
    elif vol < 66:
        icon, color = "󰖀", COLORS["CYAN"]
    else:
        icon, color = "󰕾", COLORS["CYAN"]
    
    sbar_set(name, {
        "label": f"{vol}%",
        "icon": icon,
        "icon.color": color
    })

if __name__ == "__main__":
    main()
