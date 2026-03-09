#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def get_cpu():
    res = subprocess.run(["top", "-l", "1", "-n", "0"], capture_output=True, text=True)
    try:
        line = [l for l in res.stdout.split("\n") if l.strip().startswith("CPU usage")][0]
        usage = line.split(":")[1].split("% user")[0].strip()
        return f"{int(float(usage))}%", "󰍛", COLORS["YELLOW"]
    except: return "0%", "󰍛", COLORS["YELLOW"]

def get_ram():
    res = subprocess.run(["memory_pressure"], capture_output=True, text=True)
    try:
        line = [l for l in res.stdout.split("\n") if "System-wide memory free percentage" in line][0]
        free = int(line.split(":")[1].strip().replace("%", ""))
        usage = 100 - free
        return f"{usage}%", "󰘚", COLORS["CYAN"]
    except: return "0%", "󰘚", COLORS["CYAN"]

def main():
    name = os.environ.get("NAME", "")
    if "cpu" in name:
        val, icon, color = get_cpu()
        subprocess.run(["sketchybar", "--set", name, f"label={val}", f"icon={icon}", f"icon.color={color}", f"label.color={COLORS['WHITE']}"])
    elif "ram" in name:
        val, icon, color = get_ram()
        subprocess.run(["sketchybar", "--set", name, f"label={val}", f"icon={icon}", f"icon.color={color}", f"label.color={COLORS['WHITE']}"])
    elif "gpu" in name:
        subprocess.run(["sketchybar", "--set", name, f"icon=󰢮", f"icon.color={COLORS['GREEN']}", f"label.color={COLORS['WHITE']}"])

if __name__ == "__main__":
    main()
