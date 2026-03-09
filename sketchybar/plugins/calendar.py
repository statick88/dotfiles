#!/usr/bin/env python3
import subprocess
import os
from datetime import datetime
from utils import COLORS, sbar_set

def main():
    sender = os.environ.get("SENDER", "")
    
    if sender == "mouse.clicked":
        # Abrir Google Calendar en Google Chrome
        url = "https://calendar.google.com/calendar/u/0/r"
        subprocess.run(["open", "-a", "Google Chrome", url])
    else:
        # Actualización normal del reloj/fecha
        now = datetime.now()
        # Formato elegante: "Dom 08 Mar 20:30"
        date_str = now.strftime("%a %d %b %H:%M")
        
        sbar_set("datetime", {
            "label": date_str,
            "label.color": COLORS["WHITE"],
            "icon.drawing": "off"
        })

if __name__ == "__main__":
    main()
