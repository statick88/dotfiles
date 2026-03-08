#!/usr/bin/env python3
"""
Consolidated system stats plugin: CPU + GPU + RAM
Updates all three items in a single call to reduce subprocess overhead.
Handles errors gracefully — if one stat fails, others still update.
"""

import os
import subprocess
import re


# Colors
CPU_COLOR_OK = "0xff5f87af"
CPU_COLOR_WARNING = "0xffd75f5f"

GPU_RED = "0xffcb7c94"
GPU_YELLOW = "0xffffe066"
GPU_ORANGE = "0xfffff7b1"

RAM_RED = "0xffcb7c94"
RAM_YELLOW = "0xffffe066"
RAM_MAGENTA = "0xffff8dd7"


def get_cpu_usage():
    """Read CPU usage from 'top' command. Returns percentage or None."""
    try:
        result = subprocess.run(
            ["top", "-l", "1", "-n", "0"], capture_output=True, text=True, timeout=5
        )

        for line in result.stdout.splitlines():
            if "CPU usage:" in line:
                match = re.search(r"(\d+\.?\d*)% user", line)
                if match:
                    return int(float(match.group(1)))

        return None
    except Exception:
        return None


def get_gpu_usage():
    """Read GPU usage from ioreg. Returns percentage or None."""
    try:
        result = subprocess.run(
            ["ioreg", "-r", "-d", "1", "-c", "IOAccelerator"],
            capture_output=True,
            text=True,
            timeout=5,
        )

        match = re.search(r'"Device Utilization %"=(\d+)', result.stdout)
        if match:
            return int(match.group(1))

        return None
    except Exception:
        return None


def get_memory_usage():
    """Read memory usage from 'memory_pressure' command. Returns percentage or None."""
    try:
        result = subprocess.run(
            ["memory_pressure"], capture_output=True, text=True, timeout=5
        )

        for line in result.stdout.splitlines():
            if "System-wide memory free percentage:" in line:
                match = re.search(r"(\d+)%", line)
                if match:
                    free_percent = int(match.group(1))
                    used_percent = 100 - free_percent
                    return used_percent

        return None
    except Exception:
        return None


def get_cpu_color(cpu_percent):
    """Color based on CPU usage threshold."""
    if cpu_percent is None:
        return CPU_COLOR_OK
    return CPU_COLOR_WARNING if cpu_percent > 80 else CPU_COLOR_OK


def get_gpu_color(gpu_percent):
    """Color based on GPU usage threshold."""
    if gpu_percent is None:
        return GPU_ORANGE
    elif gpu_percent >= 80:
        return GPU_RED
    elif gpu_percent >= 50:
        return GPU_YELLOW
    else:
        return GPU_ORANGE


def get_ram_color(mem_percent):
    """Color based on RAM usage threshold."""
    if mem_percent is None:
        return RAM_MAGENTA
    elif mem_percent >= 80:
        return RAM_RED
    elif mem_percent >= 60:
        return RAM_YELLOW
    else:
        return RAM_MAGENTA


def main():
    # Get all stats
    cpu_percent = get_cpu_usage()
    gpu_percent = get_gpu_usage()
    mem_percent = get_memory_usage()

    # Format labels
    cpu_label = f"CPU {cpu_percent}%" if cpu_percent is not None else "CPU --"
    gpu_label = f"{gpu_percent}%" if gpu_percent is not None else "--"
    ram_label = f"{mem_percent}%" if mem_percent is not None else "--"

    # Get colors
    cpu_color = get_cpu_color(cpu_percent)
    gpu_color = get_gpu_color(gpu_percent)
    ram_color = get_ram_color(mem_percent)

    # Update all three items in a single subprocess call
    cmd = [
        "sketchybar",
        "--set",
        "cpu",
        f"label={cpu_label}",
        f"label.color={cpu_color}",
        "--set",
        "gpu",
        f"label={gpu_label}",
        f"icon.color={gpu_color}",
        "--set",
        "ram",
        f"label={ram_label}",
        f"icon.color={ram_color}",
    ]

    try:
        subprocess.run(cmd, timeout=5)
    except Exception as e:
        # Silently fail — items will show stale data
        pass


if __name__ == "__main__":
    main()
