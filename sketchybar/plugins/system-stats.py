#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set


def get_cpu_usage() -> tuple[str, str, str]:
    """Retrieves CPU usage percentage using top command."""
    try:
        result = subprocess.run(
            ["top", "-l", "1", "-n", "0"], capture_output=True, text=True, timeout=10
        )
        cpu_lines = [
            line
            for line in result.stdout.split("\n")
            if line.strip().startswith("CPU usage")
        ]
        if not cpu_lines:
            raise ValueError("CPU usage line not found in top output")

        cpu_line = cpu_lines[0]
        usage = cpu_line.split(":")[1].split("% user")[0].strip()
        return f"{int(float(usage))}%", "󰍛", COLORS["YELLOW"]
    except Exception as e:
        error_msg = (
            "Command timed out" if isinstance(e, subprocess.TimeoutExpired) else str(e)
        )
        print(f"Error getting CPU usage: {error_msg}")
        return "0%", "󰍛", COLORS["YELLOW"]


def get_ram_usage() -> tuple[str, str, str]:
    """Retrieves RAM usage percentage using memory_pressure command."""
    try:
        result = subprocess.run(
            ["memory_pressure"], capture_output=True, text=True, timeout=10
        )
        ram_lines = [
            line
            for line in result.stdout.split("\n")
            if "System-wide memory free percentage" in line
        ]
        if not ram_lines:
            raise ValueError("RAM usage line not found in memory_pressure output")

        ram_line = ram_lines[0]
        free_percent = int(ram_line.split(":")[1].strip().replace("%", ""))
        usage_percent = 100 - free_percent
        return f"{usage_percent}%", "󰘚", COLORS["CYAN"]
    except Exception as e:
        error_msg = (
            "Command timed out" if isinstance(e, subprocess.TimeoutExpired) else str(e)
        )
        print(f"Error getting RAM usage: {error_msg}")
        return "0%", "󰘚", COLORS["CYAN"]


def get_gpu_usage() -> tuple[str, str, str]:
    """Retrieves GPU usage percentage using powermetrics (macOS specific)."""
    try:
        # Use powermetrics for more detailed GPU usage (supported on Apple Silicon)
        result = subprocess.run(
            ["powermetrics", "--samplers", "gpu_power", "-n", "1"],
            capture_output=True,
            text=True,
            timeout=10,
        )

        # For Intel GPUs, we might need to use a different approach
        if "GPU" not in result.stdout:
            # Fallback for Intel GPUs or systems without powermetrics support
            result = subprocess.run(
                ["system_profiler", "SPGPUDataType"],
                capture_output=True,
                text=True,
                timeout=10,
            )
            if "Metal: Supported" in result.stdout:
                return "0%", "󰢮", COLORS["GREEN"]
            return "0%", "󰢮", COLORS["GREEN"]

        # Parse GPU usage from powermetrics output
        gpu_usage = 0
        for line in result.stdout.split("\n"):
            if "GPU Activity" in line or "GPU usage" in line:
                # Example line: "GPU Activity: 45%"
                try:
                    gpu_usage = int(line.split(":")[1].strip().replace("%", ""))
                    break
                except (IndexError, ValueError):
                    continue

        return f"{gpu_usage}%", "󰢮", COLORS["GREEN"]
    except Exception as e:
        error_msg = (
            "Command timed out" if isinstance(e, subprocess.TimeoutExpired) else str(e)
        )
        print(f"Error getting GPU usage: {error_msg}")
        return "0%", "󰢮", COLORS["GREEN"]


# Aliases for backward compatibility with tests
get_cpu = get_cpu_usage
get_ram = get_ram_usage
get_gpu = get_gpu_usage


def main():
    """Main function to update system stats in SketchyBar."""
    name = os.environ.get("NAME", "")

    if "cpu" in name:
        val, icon, color = get_cpu_usage()
    elif "ram" in name:
        val, icon, color = get_ram_usage()
    elif "gpu" in name:
        val, icon, color = get_gpu_usage()
    else:
        print(f"Unknown system stat: {name}")
        return

    sbar_set(
        name,
        {
            "label": val,
            "icon": icon,
            "icon.color": color,
            "label.color": COLORS["WHITE"],
        },
    )


if __name__ == "__main__":
    main()
