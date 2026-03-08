#!/usr/bin/env python3

import os
import subprocess
import re

# Colors
RED = "0xffcb7c94"
YELLOW = "0xffffe066"
MAGENTA = "0xffff8dd7"


def get_memory_usage():
    """
    Lee memory usage usando 'memory_pressure'.
    Retorna porcentaje de memoria usada (100 - free%).
    """
    try:
        result = subprocess.run(
            ["memory_pressure"], capture_output=True, text=True, timeout=5
        )

        # Buscar línea: "System-wide memory free percentage: XX%"
        for line in result.stdout.splitlines():
            if "System-wide memory free percentage:" in line:
                # Extraer número
                match = re.search(r"(\d+)%", line)
                if match:
                    free_percent = int(match.group(1))
                    used_percent = 100 - free_percent
                    return used_percent

        return None
    except Exception:
        return None


def get_color(mem_percent):
    """Retorna color basado en umbral de uso."""
    if mem_percent is None:
        return MAGENTA
    elif mem_percent >= 80:
        return RED
    elif mem_percent >= 60:
        return YELLOW
    else:
        return MAGENTA


def main():
    name = os.environ.get("NAME", "ram")

    mem_percent = get_memory_usage()

    if mem_percent is None:
        label = "--"
    else:
        label = f"{mem_percent}%"

    color = get_color(mem_percent)

    subprocess.run(
        ["sketchybar", "--set", name, f"label={label}", f"icon.color={color}"]
    )


if __name__ == "__main__":
    main()
