#!/usr/bin/env python3
import os
from datetime import datetime
from utils import COLORS, sbar_set

# ACADEMIC MILESTONES (Diego Saavedra - UCM)
MILESTONES = [
    {"name": "Práctica Criptografía", "date": "2026-03-25"},
    {"name": "Examen Auditoría", "date": "2026-04-10"},
    {"name": "Propuesta TFM", "date": "2026-05-15"},
]

def get_countdown():
    """Calculates days left for the next milestone."""
    now = datetime.now()
    upcoming = []
    for m in MILESTONES:
        m_date = datetime.strptime(m["date"], "%Y-%m-%d")
        diff = (m_date - now).days
        if diff >= 0:
            upcoming.append({"name": m["name"], "days": diff})
    
    # Sort by nearest
    upcoming.sort(key=lambda x: x["days"])
    return upcoming

def main():
    name = os.environ.get("NAME", "ucm")
    sender = os.environ.get("SENDER", "")
    
    milestones = get_countdown()
    
    if sender == "mouse.entered":
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        
        sbar_set("ucm.header", {"label": "Hitos Académicos UCM", "drawing": "on"})
        
        for i in range(1, 4):
            item_name = f"ucm.m{i}"
            if i <= len(milestones):
                m = milestones[i-1]
                sbar_set(item_name, {
                    "label": f"{m['name']}: {m['days']} días",
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
    if milestones:
        nearest = milestones[0]
        label = f"{nearest['days']}d"
        icon_color = COLORS["RED"] if nearest['days'] < 7 else COLORS["BLUE"]
        sbar_set(name, {
            "label": label,
            "icon.color": icon_color,
            "label.drawing": "on"
        })
    else:
        sbar_set(name, {"label.drawing": "off", "icon.color": COLORS["DIM"]})

if __name__ == "__main__":
    main()
