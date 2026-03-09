#!/usr/bin/env python3
import subprocess
import os
from datetime import datetime
from utils import COLORS, sbar_set

def main():
    # Use environment NAME if available, otherwise default to datetime
    name = os.environ.get("NAME", "datetime")
    sender = os.environ.get("SENDER", "")
    
    if sender == "mouse.clicked":
        # Opens Google Calendar in default browser (Chrome as preferred in your config)
        url = "https://calendar.google.com/calendar/u/0/r"
        subprocess.run(["open", "-a", "Google Chrome", url], capture_output=True)
    else:
        # Update clock/date: "Mon 09 Mar | 14:30" (24h format with separator)
        now = datetime.now()
        date_str = now.strftime("%a %d %b | %H:%M")
        
        sbar_set(name, {
            "label": date_str,
            "label.color": COLORS["WHITE"],
            "icon.drawing": "off"
        })

if __name__ == "__main__":
    main()
