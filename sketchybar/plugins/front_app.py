#!/usr/bin/env python3
import subprocess
import os
import re
from utils import COLORS, sbar_set

# Striking Icon mapping for common applications (Nerd Fonts)
APP_ICONS = {
    "Finder": "󰀶",
    "Safari": "󰀹",
    "Google Chrome": "󰊯",
    "Ghostty": "󰞷",
    "Alacritty": "󰞷",
    "iTerm2": "󰞷",
    "Terminal": "󰞷",
    "kitty": "󰞷",
    "Visual Studio Code": "󰨞",
    "Code": "󰨞",
    "Spotify": "󰎆",
    "Music": "󰎆",
    "Slack": "󰒱",
    "Discord": "󰙯",
    "Messages": "󰍦",
    "Mail": "󰇮",
    "Calendar": "󰃭",
    "Settings": "󰒓",
    "System Settings": "󰒓",
    "Activity Monitor": "󰢮",
    "Preview": "󰋩",
    "Notes": "󰎚",
    "Notion": "󰎚",
    "Arc": "󰀹",
    "Brave Browser": "󰊯",
    "WhatsApp": "󰍵",
    "Telegram": "󰈚",
    "Xcode": "󰨞",
}

DEFAULT_ICON = "󰈙"

def get_front_app_info():
    """Gets frontmost app name and its pid using reliable methods."""
    app_name = "Unknown"
    pid = None
    try:
        # Get Name (Reliable method)
        res = subprocess.run(["osascript", "-e", 'tell application "System Events" to name of first process whose frontmost is true'], capture_output=True, text=True)
        if res.returncode == 0:
            app_name = res.stdout.strip()
        
        # Get PID (Reliable method)
        res_pid = subprocess.run(["osascript", "-e", 'tell application "System Events" to unix id of first process whose frontmost is true'], capture_output=True, text=True)
        if res_pid.returncode == 0:
            pid = res_pid.stdout.strip()
    except:
        pass
    return app_name, pid

def get_process_stats(pid):
    """Gets CPU and RAM usage for a specific PID."""
    if not pid: return "N/A", "N/A"
    try:
        res = subprocess.run(["ps", "-p", pid, "-o", "%cpu,%mem"], capture_output=True, text=True)
        lines = res.stdout.splitlines()
        if len(lines) > 1:
            stats = lines[1].split()
            return f"{float(stats[0]):.1f}%", f"{float(stats[1]):.1f}%"
    except: pass
    return "0%", "0%"

def main():
    name = os.environ.get("NAME", "front_app")
    sender = os.environ.get("SENDER", "")
    
    app, pid = get_front_app_info()
    icon = APP_ICONS.get(app, DEFAULT_ICON)
    
    if sender == "mouse.entered":
        cpu, mem = get_process_stats(pid)
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        sbar_set(f"{name}.details", {
            "label": f"App: {app} {'(PID: '+pid+')' if pid else ''}",
            "icon": icon,
            "icon.color": COLORS["CYAN"],
            "drawing": "on"
        })
        sbar_set(f"{name}.monitor", {
            "label": f"Uso: CPU {cpu} | RAM {mem}",
            "icon": "󰢮",
            "icon.color": COLORS["RED"] if cpu != "N/A" and float(cpu.replace('%','')) > 20 else COLORS["GREEN"],
            "drawing": "on"
        })
        return
    
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Update Bar - Ensure it ALWAYS shows at least the app name
    sbar_set(name, {
        "label": app,
        "icon": icon,
        "label.color": COLORS["WHITE"],
        "icon.color": COLORS["WHITE"],
        "icon.drawing": "on",
        "label.drawing": "on"
    })

if __name__ == "__main__":
    main()
