#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def get_docker_containers():
    """Gets running docker containers using docker ps."""
    try:
        # Get count and names of running containers
        # Format: "ID|Name|Status"
        res = subprocess.run(
            ["docker", "ps", "--format", "{{.ID}}|{{.Names}}|{{.Status}}"],
            capture_output=True, text=True, timeout=5
        )
        if res.returncode != 0:
            return []
        
        containers = []
        for line in res.stdout.splitlines():
            if line.strip():
                parts = line.split("|")
                if len(parts) == 3:
                    containers.append({"id": parts[0], "name": parts[1], "status": parts[2]})
        return containers
    except:
        return []

def main():
    name = os.environ.get("NAME", "docker")
    sender = os.environ.get("SENDER", "")
    
    containers = get_docker_containers()
    count = len(containers)

    if sender == "mouse.entered":
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        
        sbar_set("docker.header", {"label": f"Contenedores Activos: {count}", "drawing": "on"})
        
        for i in range(1, 6):
            item_name = f"docker.c{i}"
            if i <= count:
                c = containers[i-1]
                sbar_set(item_name, {
                    "label": f"{c['name']} ({c['status']})",
                    "drawing": "on",
                    "label.drawing": "on"
                })
            else:
                sbar_set(item_name, {"drawing": "off"})
        return
    
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Regular Bar Update
    # Icon color: Green if containers > 0, Dim if 0
    icon_color = COLORS["BLUE"] if count > 0 else COLORS["DIM"]
    sbar_set(name, {
        "label": f"{count}" if count > 0 else "",
        "icon.color": icon_color,
        "label.drawing": "on" if count > 0 else "off"
    })

if __name__ == "__main__":
    main()
