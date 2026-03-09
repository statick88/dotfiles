#!/usr/bin/env python3
import subprocess
import os
import re
from utils import COLORS, sbar_set

BLUEUTIL = "/opt/homebrew/bin/blueutil"

def run(cmd):
    try:
        return subprocess.run(cmd, capture_output=True, text=True, timeout=2).stdout
    except:
        return ""

def get_wifi_status():
    """Returns (Icon, Color) for current WiFi status."""
    # Fast check using scutil for actual connectivity
    res = run(["scutil", "--nwi"])
    # If en0 is present and Reachable, it means we are connected to a network
    if "en0" in res and "Reachable" in res:
        return "󰤨", COLORS["BLUE"] # Connected
    
    # Check if Wi-Fi power is even on
    power = run(["networksetup", "-getairportpower", "en0"])
    if "On" in power:
        return "󰤯", COLORS["DIM"] # On but not connected
    else:
        return "󰤮", COLORS["RED"] # Off

def get_bt_status():
    """Returns (Icon, Color) for current Bluetooth status."""
    if os.path.exists(BLUEUTIL):
        is_on = run([BLUEUTIL, "-p"]).strip() == "1"
        if not is_on:
            return "󰂲", COLORS["DIM"] # Off
        
        # Check if any device is connected
        connected_devices = run([BLUEUTIL, "--connected"]).strip()
        if connected_devices:
            return "󰂱", COLORS["MAGENTA"] # Connected
        else:
            return "󰂯", COLORS["MAGENTA"] # On
    else:
        # Fallback to system_profiler (slower)
        res = run(["system_profiler", "SPBluetoothDataType", "-detailLevel", "mini"])
        if "State: On" in res:
            if "Connected: Yes" in res:
                return "󰂱", COLORS["MAGENTA"]
            else:
                return "󰂯", COLORS["MAGENTA"]
        else:
            return "󰂲", COLORS["DIM"]

def populate_wifi_menu(name):
    """Lists saved/available networks in popup."""
    subprocess.run(["sketchybar", "--remove", f"/{name}.ssid..*/"])
    res = run(["networksetup", "-listpreferredwirelessnetworks", "en0"])
    networks = [n.strip() for n in res.splitlines()[1:6] if n.strip()]
    
    for i, ssid in enumerate(networks):
        item_name = f"{name}.ssid.{i}"
        subprocess.run([
            "sketchybar", "--add", "item", item_name, f"popup.{name}",
            "--set", item_name, 
            f"label={ssid}",
            "label.drawing=on",
            f"click_script=networksetup -setairportnetwork en0 '{ssid}'; sketchybar --set {name} popup.drawing=off"
        ])

def populate_bt_menu(name):
    """Lists paired devices in popup."""
    subprocess.run(["sketchybar", "--remove", f"/{name}.dev..*/"])
    if os.path.exists(BLUEUTIL):
        res = run([BLUEUTIL, "--paired"])
        devices = re.findall(r'name: "(.*?)"', res)
    else:
        res = run(["system_profiler", "SPBluetoothDataType"])
        devices = re.findall(r"Name: (.*)\s+Address:", res)
    
    devices = list(dict.fromkeys(devices))[:5]
    for i, dev in enumerate(devices):
        item_name = f"{name}.dev.{i}"
        subprocess.run([
            "sketchybar", "--add", "item", item_name, f"popup.{name}",
            "--set", item_name, 
            f"label={dev}",
            "label.drawing=on",
            f"click_script=sketchybar --set {name} popup.drawing=off"
        ])

def main():
    name = os.environ.get("NAME", "wifi")
    sender = os.environ.get("SENDER", "")
    
    if name == "wifi":
        icon, color = get_wifi_status()
    else:
        icon, color = get_bt_status()
    
    # ENSURE NO TEXT LABELS IN THE BAR
    # We set label="" and label.drawing=off to be absolutely sure
    sbar_set(name, {
        "label": "", 
        "label.drawing": "off",
        "icon": icon, 
        "icon.color": color
    })

    if sender == "mouse.clicked":
        subprocess.run(["sketchybar", "--set", name, "popup.drawing=toggle"])
        if name == "wifi":
            populate_wifi_menu(name)
        else:
            populate_bt_menu(name)

if __name__ == "__main__":
    main()
