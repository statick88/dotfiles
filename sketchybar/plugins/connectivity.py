#!/usr/bin/env python3
import subprocess
import os
import re
import time
from utils import COLORS, sbar_set, get_state, save_state

def get_active_interface():
    """Finds the interface with the default route."""
    try:
        res = subprocess.run(["route", "-n", "get", "default"], capture_output=True, text=True)
        match = re.search(r"interface:\s+(.*)", res.stdout)
        if match:
            return match.group(1).strip()
    except: pass
    return "en0"

def get_net_traffic(interface):
    """Gets total input/output bytes for the interface."""
    try:
        res = subprocess.run(["netstat", "-ibn", "-I", interface], capture_output=True, text=True)
        lines = res.stdout.splitlines()
        if len(lines) > 1:
            for line in lines[1:]:
                parts = line.split()
                if len(parts) >= 10 and (parts[2].startswith("<Link") or "Link" in line):
                    return int(parts[6]), int(parts[9])
            parts = lines[1].split()
            if len(parts) >= 10:
                return int(parts[6]), int(parts[9])
    except: pass
    return 0, 0

def get_wifi_info(interface):
    """Robust network info check (IP, SSID, Mask, Router)."""
    data = {"ip": "Sin IP", "ssid": "", "mask": "N/A", "router": "N/A"}
    try:
        ip_res = subprocess.run(["ipconfig", "getifaddr", interface], capture_output=True, text=True)
        ip = ip_res.stdout.strip()
        if ip:
            data["ip"] = ip
            ssid_res = subprocess.run(["networksetup", "-getairportnetwork", interface], capture_output=True, text=True)
            ssid_match = re.search(r":\s+(.*)", ssid_res.stdout)
            data["ssid"] = ssid_match.group(1).strip() if ssid_match else "Conectado"
            
            ifconfig = subprocess.run(["ifconfig", interface], capture_output=True, text=True).stdout
            mask_match = re.search(r"netmask\s+(0x[0-9a-fA-F]+)", ifconfig)
            if mask_match:
                h = mask_match.group(1)[2:]
                data["mask"] = ".".join(map(str, [int(h[i:i+2], 16) for i in range(0, 8, 2)]))
            
            route_res = subprocess.run(["netstat", "-rn"], capture_output=True, text=True).stdout
            for line in route_res.splitlines():
                if "default" in line and interface in line:
                    parts = line.split()
                    if len(parts) > 1: data["router"] = parts[1]; break
    except: pass
    return data

def get_bt_info():
    """Gets Bluetooth status and connected devices."""
    data = {"status": "Apagado", "devices": []}
    try:
        bt_info = subprocess.run(["system_profiler", "SPBluetoothDataType"], capture_output=True, text=True).stdout
        if "State: On" in bt_info or "Power: On" in bt_info: data["status"] = "Encendido"
        current_name = None
        for line in bt_info.splitlines():
            if "Name: " in line: current_name = line.split(":")[1].strip()
            if "Connected: Yes" in line and current_name: data["devices"].append(current_name)
        data["devices"] = list(set(data["devices"]))
    except: pass
    return data

def format_speed(bytes_per_sec):
    if bytes_per_sec < 1024: return f"{bytes_per_sec:.0f}B"
    elif bytes_per_sec < 1024 * 1024: return f"{bytes_per_sec / 1024:.0f}K"
    else: return f"{bytes_per_sec / (1024 * 1024):.1f}M"

def update_popups(name, interface, speed_in, speed_out, hide_details=False):
    """Synchronized with sketchybarrc. Implements OPSEC/Cybersecurity hide logic."""
    if name == "wifi":
        info = get_wifi_info(interface)
        if hide_details:
            # Cybersecurity Mode: Hide sensitive data
            sbar_set("wifi.info.ip", {"label": "IP: [PROTECTED]"})
            sbar_set("wifi.info.mask", {"label": "Mask: [PROTECTED]"})
            sbar_set("wifi.info.router", {"label": "Router: [PROTECTED]"})
            sbar_set("wifi.info.speed", {"label": f"↓{format_speed(speed_in)}/s ↑{format_speed(speed_out)}/s"})
        else:
            sbar_set("wifi.info.ip", {"label": f"IP: {info['ip']}"})
            sbar_set("wifi.info.mask", {"label": f"Mask: {info['mask']}"})
            sbar_set("wifi.info.router", {"label": f"Router: {info['router']}"})
            sbar_set("wifi.info.speed", {"label": f"↓{format_speed(speed_in)}/s ↑{format_speed(speed_out)}/s"})
    elif name == "bluetooth":
        info = get_bt_info()
        sbar_set("bluetooth.info.status", {"label": f"Estado: {info['status']}"})
        if hide_details:
            sbar_set("bluetooth.info.devices", {"label": "Equipos: [HIDDEN]"})
        else:
            dev_str = ", ".join(info["devices"]) if info["devices"] else "Ninguno"
            sbar_set("bluetooth.info.devices", {"label": f"Equipos: {dev_str}"})

def main():
    name = os.environ.get("NAME", "wifi")
    sender = os.environ.get("SENDER", "")
    now = time.time()
    interface = get_active_interface()
    
    # SYSTEM MODE AWARENESS (OPSEC)
    mode_state = get_state("modes", {"mode": "normal"})
    is_cybersecurity = (mode_state["mode"] == "hacking")

    state = get_state("connectivity", {"last_ib": 0, "last_ob": 0, "last_t": now})
    ib, ob = get_net_traffic(interface)
    t_diff = max(0.1, now - state["last_t"])
    speed_in = (ib - state["last_ib"]) / t_diff if state["last_ib"] > 0 else 0
    speed_out = (ob - state["last_ob"]) / t_diff if state["last_ob"] > 0 else 0
    save_state("connectivity", {"last_ib": ib, "last_ob": ob, "last_t": now})

    if sender == "mouse.entered":
        update_popups(name, interface, speed_in, speed_out, hide_details=is_cybersecurity)
        sbar_set(name, {"popup.drawing": "on"})
        return
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Regular update
    update_popups(name, interface, speed_in, speed_out, hide_details=is_cybersecurity)

    if name == "wifi":
        info = get_wifi_info(interface)
        is_connected = (info["ip"] != "Sin IP")
        
        label = ""
        if is_connected:
            label = "" if is_cybersecurity else info["ssid"]
            
        sbar_set(name, {
            "icon": "󰤨" if is_connected else "󰤮",
            "icon.color": COLORS["BLUE"] if is_connected else COLORS["DIM"],
            "label": label,
            "label.drawing": "on" if label else "off"
        })
    elif name == "bluetooth":
        info = get_bt_info()
        icon = "󰂱" if info["devices"] else "󰂯"
        color = COLORS["MAGENTA"] if info["status"] == "Encendido" else COLORS["DIM"]
        
        label = ""
        if info["devices"]:
            label = "" if is_cybersecurity else f"{len(info['devices'])}"
            
        sbar_set(name, {
            "icon": icon,
            "icon.color": color,
            "label": label,
            "label.drawing": "on" if label else "off"
        })

if __name__ == "__main__":
    main()
