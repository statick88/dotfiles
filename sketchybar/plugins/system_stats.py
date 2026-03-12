#!/usr/bin/env python3
import subprocess
import os
import re
from utils import COLORS, sbar_set

def make_bar(percent, size=10):
    """Creates a visual text bar: [████░░░░]"""
    try:
        p = int(float(str(percent).replace('%', '')))
        filled = max(0, min(size, int(p / (100 / size))))
        return "█" * filled + "░" * (size - filled)
    except: return "░" * size

def get_color(percent):
    """Returns a color based on percentage usage."""
    try:
        p = int(float(str(percent).replace('%', '')))
        if p < 50: return COLORS["GREEN"]
        if p < 80: return COLORS["YELLOW"]
        return COLORS["RED"]
    except: return COLORS["WHITE"]

def get_cpu_info():
    """Gets CPU usage efficiently."""
    try:
        res = subprocess.run(["top", "-l", "1", "-n", "0"], capture_output=True, text=True)
        match = re.search(r"CPU usage: (\d+\.\d+)% user, (\d+\.\d+)% sys", res.stdout)
        if match:
            u, s = float(match.group(1)), float(match.group(2))
            total = int(u + s)
            return f"{total}%", total, f"User: {u}% | Sys: {s}%"
    except: pass
    return "0%", 0, "CPU: N/A"

def get_ram_info():
    """Gets RAM usage using vm_stat with a robust top fallback."""
    try:
        # Preferred method: vm_stat
        page_size = int(subprocess.check_output(["pagesize"]))
        vm = subprocess.check_output(["vm_stat"]).decode('utf-8')
        def get_val(key):
            return int(re.search(rf"{key}:\s+(\d+)", vm).group(1)) * page_size
        
        free = get_val("Pages free")
        spec = get_val("Pages speculative")
        total = int(subprocess.check_output(["sysctl", "-n", "hw.memsize"]))
        used = total - (free + spec)
        pct = int((used / total) * 100)
        used_gb = used / (1024**3)
        total_gb = total / (1024**3)
        return f"{pct}%", pct, f"{used_gb:.1f} GB de {total_gb:.0f} GB"
    except:
        # Fallback method: top
        try:
            res = subprocess.run(["top", "-l", "1", "-n", "0"], capture_output=True, text=True)
            # Robust regex for different macOS formats
            match = re.search(r"PhysMem:\s+(\d+)([MG])\s+used.*?\s+(\d+)([MG])\s+unused", res.stdout)
            if match:
                used_val, used_unit = int(match.group(1)), match.group(2)
                free_val, free_unit = int(match.group(3)), match.group(4)
                u_gb = used_val if used_unit == 'G' else used_val / 1024
                f_gb = free_val if free_unit == 'G' else free_val / 1024
                total_gb = u_gb + f_gb
                pct = int((u_gb / total_gb) * 100)
                return f"{pct}%", pct, f"{u_gb:.1f} GB de {total_gb:.0f} GB"
        except: pass
    return "0%", 0, "RAM: N/A"

def get_gpu_info():
    """Gets GPU info."""
    usage_str, usage_int, model = "0%", 0, "Apple GPU"
    try:
        res_prof = subprocess.run(["system_profiler", "SPGPUDataType"], capture_output=True, text=True)
        model_match = re.search(r"Chipset Model: (.*)", res_prof.stdout)
        if model_match: model = model_match.group(1).strip()
        
        res_ioreg = subprocess.run(["ioreg", "-r", "-l", "-c", "IOAccelerator"], capture_output=True, text=True)
        util_match = re.search(r"\"Device Utilization %\"=(\d+)", res_ioreg.stdout)
        if util_match:
            usage_int = int(util_match.group(1))
            usage_str = f"{usage_int}%"
    except: pass
    return usage_str, usage_int, model

def get_disk_info():
    """Gets Disk metrics."""
    try:
        res = subprocess.run(["df", "-h", "/"], capture_output=True, text=True)
        line = res.stdout.splitlines()[1]
        parts = line.split()
        size_str, avail_str = parts[1], parts[3]
        def to_gb(s):
            val = float(re.sub(r'[^\d.]', '', s))
            return val if 'G' in s or 'i' in s else val / 1024
        size_gb = to_gb(size_str)
        free_gb = to_gb(avail_str)
        used_gb = size_gb - free_gb
        pct = int((used_gb / size_gb) * 100)
        return f"{pct}%", pct, f"{used_gb:.0f} GB de {size_gb:.0f} GB"
    except: pass
    return "0%", 0, "Disk: N/A"

def main():
    name = os.environ.get("NAME", "")
    sender = os.environ.get("SENDER", "")
    
    if "cpu" in name:
        val_str, val_int, detail = get_cpu_info()
        color = get_color(val_int)
        bar = make_bar(val_int)
        sbar_set("cpu.info.used", {"label": bar, "label.color": color})
        sbar_set("cpu.info.load", {"label": detail})
        if sender == "mouse.entered": sbar_set(name, {"popup.drawing": "on"})
        elif sender == "mouse.exited": sbar_set(name, {"popup.drawing": "off"})
        sbar_set(name, {"label": val_str, "icon.color": color})

    elif "ram" in name:
        val_str, val_int, detail = get_ram_info()
        color = get_color(val_int)
        bar = make_bar(val_int)
        sbar_set("ram.info.used", {"label": bar, "label.color": color})
        sbar_set("ram.info.free", {"label": detail})
        if sender == "mouse.entered": sbar_set(name, {"popup.drawing": "on"})
        elif sender == "mouse.exited": sbar_set(name, {"popup.drawing": "off"})
        sbar_set(name, {"label": val_str, "icon.color": color})

    elif "gpu" in name:
        val_str, val_int, detail = get_gpu_info()
        color = get_color(val_int)
        bar = make_bar(val_int)
        sbar_set("gpu.info.used", {"label": bar, "label.color": color})
        sbar_set("gpu.info.model", {"label": detail})
        if sender == "mouse.entered": sbar_set(name, {"popup.drawing": "on"})
        elif sender == "mouse.exited": sbar_set(name, {"popup.drawing": "off"})
        sbar_set(name, {"label": val_str, "icon.color": color})

    elif "disk" in name:
        val_str, val_int, detail = get_disk_info()
        color = get_color(val_int)
        bar = make_bar(val_int)
        sbar_set("disk.info.used", {"label": bar, "label.color": color})
        sbar_set("disk.info.free", {"label": detail})
        if sender == "mouse.entered": sbar_set(name, {"popup.drawing": "on"})
        elif sender == "mouse.exited": sbar_set(name, {"popup.drawing": "off"})
        sbar_set(name, {"label": val_str, "icon.color": color})

if __name__ == "__main__":
    main()
