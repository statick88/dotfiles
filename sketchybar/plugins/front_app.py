#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def main():
    res = subprocess.run(["osascript", "-e", 'tell application "System Events" to get name of first application process whose frontmost is true'], capture_output=True, text=True)
    app = res.stdout.strip()
    
    sbar_set("front_app", {
        "label": app,
        "label.color": COLORS["WHITE"],
        "background.border_color": COLORS["ISLAND_BORDER"]
    })

if __name__ == "__main__":
    main()
