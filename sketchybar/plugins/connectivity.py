#!/usr/bin/env python3
import subprocess
import os
import json
from utils import COLORS, sbar_set

def get_wifi():
    # 1. Intentar con airport tool
    try:
        cmd = ["/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport", "-I"]
        res = subprocess.run(cmd, capture_output=True, text=True)
        if " SSID" in res.stdout:
            ssid = [line.split(": ")[1].strip() for line in res.stdout.split("\n") if " SSID" in line][0]
            return ssid, "󰖩", COLORS["BLUE"]
    except:
        pass
    
    # 2. Intentar con networksetup
    try:
        interfaces = subprocess.run(["networksetup", "-listallhardwareports"], capture_output=True, text=True).stdout
        if "Wi-Fi" in interfaces:
            for dev in ["en0", "en1"]:
                res = subprocess.run(["networksetup", "-getairportnetwork", dev], capture_output=True, text=True)
                if "Current Wi-Fi Network" in res.stdout:
                    ssid = res.stdout.split(": ")[1].strip()
                    return ssid, "󰖩", COLORS["BLUE"]
    except:
        pass

    # 3. Fallback a ifconfig (Conectado pero sin nombre de red visible)
    res = subprocess.run(["ifconfig"], capture_output=True, text=True)
    if "status: active" in res.stdout and "inet " in res.stdout:
        return "", "󰖩", COLORS["BLUE"] # Icono conectado, sin texto "Connected"
        
    # ESTADO DESCONECTADO (Como Bluetooth)
    return "", "󰖪", COLORS["DIM"]

def main():
    name = os.environ.get("NAME", "")
    if "wifi" in name:
        label, icon, color = get_wifi()
        # Si no hay label (desconectado o modo minimal), quitamos el padding
        sbar_set(name, {
            "icon": icon, 
            "icon.color": color, 
            "label": label, 
            "label.drawing": "on" if label else "off"
        })
    elif "bluetooth" in name:
        res = subprocess.run(["system_profiler", "SPBluetoothDataType"], capture_output=True, text=True)
        if "Power: On" in res.stdout:
            sbar_set(name, {"icon": "󰂯", "icon.color": COLORS["MAGENTA"]})
        else:
            sbar_set(name, {"icon": "󰂲", "icon.color": COLORS["DIM"]})

if __name__ == "__main__":
    main()
