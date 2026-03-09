#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def main():
    name = os.environ.get("NAME", "battery")
    
    # Get battery data
    res = subprocess.run(["pmset", "-g", "batt"], capture_output=True, text=True)
    out = res.stdout
    
    try:
        # Parsing percentage
        percentage = int(out.split("%")[0].split()[-1])
        # Detect charging status more reliably
        charging = "charging" in out or "AC Power" in out or "attached" in out
    except:
        percentage = 0
        charging = False

    # Icons based on percentage
    if charging:
        icon = "󱐋" # Charging bolt
        color = COLORS["YELLOW"]
    else:
        color = COLORS["GREEN"]
        if percentage <= 10: icon, color = "󰂃", COLORS["RED"]
        elif percentage <= 20: icon, color = "󰁺", COLORS["RED"]
        elif percentage <= 30: icon = "󰁻"
        elif percentage <= 40: icon = "󰁼"
        elif percentage <= 50: icon = "󰁽"
        elif percentage <= 60: icon = "󰁾"
        elif percentage <= 70: icon = "󰁿"
        elif percentage <= 80: icon = "󰂀"
        elif percentage <= 90: icon = "󰂁"
        else: icon = "󰁹" # Full
        
    sbar_set(name, {
        "label": f"{percentage}%",
        "icon": icon,
        "icon.color": color
    })

if __name__ == "__main__":
    main()
