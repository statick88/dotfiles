#!/usr/bin/env python3

import os
import subprocess
import re

# Colors
RED = "0xffcb7c94"
YELLOW = "0xffffe066"
ORANGE = "0xfffff7b1"


def get_gpu_usage():
    """
    Lee GPU usage desde IOAccelerator usando ioreg.
    Retorna porcentaje o "--" si no está disponible.
    """
    try:
        result = subprocess.run(
            ["ioreg", "-r", "-d", "1", "-c", "IOAccelerator"],
            capture_output=True,
            text=True,
            timeout=5,
        )

        # Buscar línea con "Device Utilization %"=<número>
        match = re.search(r'"Device Utilization %"=(\d+)', result.stdout)
        if match:
            return int(match.group(1))

        return None
    except Exception:
        return None


def get_color(gpu_percent):
    """Retorna color basado en umbral de uso."""
    if gpu_percent is None:
        return ORANGE
    elif gpu_percent >= 80:
        return RED
    elif gpu_percent >= 50:
        return YELLOW
    else:
        return ORANGE


def main():
    name = os.environ.get("NAME", "gpu")

    gpu_percent = get_gpu_usage()

    if gpu_percent is None:
        label = "--"
    else:
        label = f"{gpu_percent}%"

    color = get_color(gpu_percent)

    subprocess.run(
        ["sketchybar", "--set", name, f"label={label}", f"icon.color={color}"]
    )


if __name__ == "__main__":
    main()
