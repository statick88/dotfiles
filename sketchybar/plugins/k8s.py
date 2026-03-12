#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set

def get_k8s_nodes():
    """Gets Kubernetes nodes and their status using kubectl."""
    try:
        # Get nodes and status
        # Format: NAME STATUS
        res = subprocess.run(
            ["kubectl", "get", "nodes", "--no-headers"],
            capture_output=True, text=True, timeout=5
        )
        if res.returncode != 0:
            return []
        
        nodes = []
        for line in res.stdout.splitlines():
            parts = line.split()
            if len(parts) >= 2:
                nodes.append({"name": parts[0], "status": parts[1]})
        return nodes
    except:
        return []

def main():
    name = os.environ.get("NAME", "k8s")
    sender = os.environ.get("SENDER", "")
    
    nodes = get_k8s_nodes()
    ready_count = sum(1 for n in nodes if n["status"] == "Ready")
    total_count = len(nodes)

    if sender == "mouse.entered":
        sbar_set(name, {
            "popup.drawing": "on",
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10
        })
        
        sbar_set("k8s.header", {"label": f"Nodos: {ready_count}/{total_count}", "drawing": "on"})
        
        for i in range(1, 4):
            item_name = f"k8s.n1" if i == 1 else (f"k8s.n2" if i == 2 else f"k8s.n3")
            # Correcting item mapping
            item_name = f"k8s.n{i}"
            
            if i <= total_count:
                n = nodes[i-1]
                sbar_set(item_name, {
                    "label": f"{n['name']} ({n['status']})",
                    "drawing": "on",
                    "label.drawing": "on",
                    "icon.color": COLORS["GREEN"] if n["status"] == "Ready" else COLORS["RED"]
                })
            else:
                sbar_set(item_name, {"drawing": "off"})
        return
    
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Regular Bar Update
    icon_color = COLORS["BLUE"] if ready_count == total_count and total_count > 0 else (COLORS["ORANGE"] if total_count > 0 else COLORS["DIM"])
    sbar_set(name, {
        "label": f"{ready_count}/{total_count}" if total_count > 0 else "",
        "icon.color": icon_color,
        "label.drawing": "on" if total_count > 0 else "off"
    })

if __name__ == "__main__":
    main()
