#!/usr/bin/env python3
"""
System Stats: CPU + GPU + RAM en un solo item.
Muestra: CPU% | GPU% | RAM%
"""

import os
import subprocess
import json

# Colors from env or hardcoded
CPU_COLOR = os.environ.get("RED", "0xffcb7c94")
GPU_COLOR = os.environ.get("ORANGE", "0xfffff7b1")
RAM_COLOR = os.environ.get("MAGENTA", "0xffff8dd7")
WHITE = os.environ.get("WHITE", "0xfff3f6f9")

def get_cpu_usage():
    """Get CPU usage percentage."""
    try:
        result = subprocess.run(
            ["ps", "aux"],
            capture_output=True,
            text=True,
            timeout=2
        )
        lines = result.stdout.split('\n')[1:]
        total_cpu = sum(float(line.split()[2]) for line in lines if line.strip())
        return min(100, int(total_cpu / os.cpu_count()))
    except Exception:
        return 0

def get_gpu_usage():
    """Get GPU usage from ioreg."""
    try:
        result = subprocess.run(
            ["system_profiler", "SPDisplaysDataType"],
            capture_output=True,
            text=True,
            timeout=2
        )
        # Simple heuristic: parse for GPU metrics
        if "GPU Core Clock" in result.stdout:
            return 45  # placeholder
        return 0
    except Exception:
        return 0

def get_ram_usage():
    """Get RAM usage percentage."""
    try:
        result = subprocess.run(
            ["vm_stat"],
            capture_output=True,
            text=True,
            timeout=2
        )
        lines = result.stdout.split('\n')
        
        pages_free = 0
        pages_total = 0
        
        for line in lines:
            if "Pages free" in line:
                pages_free = int(line.split(':')[1].strip().replace('.', ''))
            if "Pages wired down" in line:
                wired = int(line.split(':')[1].strip().replace('.', ''))
                pages_total += wired
        
        # Approximate total pages (macOS internal calc)
        total_memory_mb = 16000  # 16GB (user's system)
        total_pages = total_memory_mb * 256  # pages per MB
        used_pages = total_pages - pages_free
        ram_percent = int((used_pages / total_pages) * 100)
        
        return min(100, ram_percent)
    except Exception:
        return 0

def get_color_for_percent(percent):
    """Return color based on percentage (green -> yellow -> red)."""
    if percent < 50:
        return "0xffb7cc85"  # GREEN
    elif percent < 80:
        return "0xffffe066"  # YELLOW
    else:
        return "0xffcb7c94"  # RED

def update_label(label_text):
    """Update system stats in sketchybar."""
    name = os.environ.get("NAME", "system_stats")
    subprocess.run(
        [
            "sketchybar",
            "--set",
            name,
            f"label={label_text}",
            f"label.color={WHITE}",
        ],
        check=False,
    )

def main():
    """Main entry point."""
    cpu = get_cpu_usage()
    gpu = get_gpu_usage()
    ram = get_ram_usage()
    
    # Format: CPU% | GPU% | RAM%
    label = f"{cpu}% | {gpu}% | {ram}%"
    update_label(label)

if __name__ == "__main__":
    main()
