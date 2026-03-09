#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def main():
    name = os.environ.get("NAME", "volume")
    
    res = subprocess.run(["osascript", "-e", "get volume settings"], capture_output=True, text=True)
    out = res.stdout
    
    try:
        # out example: output volume:50, input volume:50, alert volume:50, output muted:false
        vol = int(out.split("output volume:")[1].split(",")[0])
        muted = "true" in out.split("output muted:")[1]
    except:
        vol, muted = 0, False

    icon = "󰕿"
    if muted or vol == 0: icon, color = "󰝟", COLORS["RED"]
    elif vol < 33: icon, color = "󰕿", COLORS["CYAN"]
    elif vol < 66: icon, color = "󰖀", COLORS["CYAN"]
    else: icon, color = "󰕾", COLORS["CYAN"]
    
    sbar_set(name, {"label": f"{vol}%", "icon": icon, "icon.color": color})

if __name__ == "__main__":
    main()
