#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set, get_state

def get_volume_settings():
    try:
        res = subprocess.run(["osascript", "-e", "get volume settings"], capture_output=True, text=True)
        out = res.stdout
        vol = int(out.split("output volume:")[1].split(",")[0])
        muted = "true" in out.split("output muted:")[1]
        return vol, muted
    except: return 0, False

def set_volume(volume):
    volume = max(0, min(100, volume))
    subprocess.run(["osascript", "-e", f"set volume output volume {volume}"])

def toggle_mute():
    subprocess.run(["osascript", "-e", "set volume output muted not (output muted of (get volume settings))"])

def make_bar(percent, size=15):
    filled = int(percent / (100 / size))
    return "█" * filled + "░" * (size - filled)

def update_popup(name, vol, muted, icon_color):
    """Updates the volume popup items."""
    bar = make_bar(vol)
    mute_label = "Silenciado" if muted else "Sonido Activo"
    mute_icon = "󰝟" if muted else "󰕾"
    
    # Update the items defined in sketchybarrc
    sbar_set(f"{name}.display", {
        "label": f"{bar} {vol}%",
        "icon": "󰕾",
        "icon.color": icon_color,
        "drawing": "on"
    })
    
    sbar_set(f"{name}.mute", {
        "label": mute_label,
        "icon": mute_icon,
        "icon.color": COLORS["RED"] if muted else COLORS["GREEN"],
        "click_script": f"NAME={name} SENDER=mouse.clicked ACTION=toggle_mute python3 {os.path.abspath(__file__)}",
        "drawing": "on"
    })

def main():
    name = os.environ.get("NAME", "volume")
    sender = os.environ.get("SENDER", "")
    action = os.environ.get("ACTION", "")
    
    if action == "toggle_mute":
        toggle_mute()
        # Keep popup open or toggle it? Usually better to refresh it.
        vol, muted = get_volume_settings()
        update_popup(name, vol, muted, COLORS["CYAN"])
        return

    # ENVIRONMENT MODE AWARENESS
    mode_state = get_state("modes", {"mode": "normal"})
    is_normal = (mode_state["mode"] == "normal")
    from modes import MODES
    mode_color = MODES.get(mode_state["mode"], MODES["normal"])["color"]

    vol, muted = get_volume_settings()
    
    # --- Handle Scroll ---
    if sender == "mouse.scrolled.up":
        vol += 5
        set_volume(vol)
    elif sender == "mouse.scrolled.down":
        vol -= 5
        set_volume(vol)
    
    icon_color = COLORS["CYAN"] if is_normal else mode_color

    if muted or vol == 0: icon, color = "󰝟", COLORS["RED"]
    elif vol < 33: icon, color = "󰕿", icon_color
    elif vol < 66: icon, color = "󰖀", icon_color
    else: icon, color = "󰕾", icon_color

    # --- Handle Events ---
    if sender == "mouse.entered":
        update_popup(name, vol, muted, color)
        sbar_set(name, {"popup.drawing": "on"})
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
    
    # In any case, update the main bar label
    sbar_set(name, {
        "label": f"{vol}%",
        "icon": icon,
        "icon.color": color,
        "label.drawing": "on",
        "icon.drawing": "on"
    })
    
    # If the popup is already drawing (e.g. during a scroll or volume change), refresh it
    # We can't easily know if it's open without querying, but updating items is cheap.
    update_popup(name, vol, muted, color)

if __name__ == "__main__":
    main()
