#!/usr/bin/env python3
import subprocess
import os
import shutil
from utils import COLORS, sbar_set, notify, play_sound

# Dynamic path detection for Zero Trust policy
TAILSCALE_PATH = shutil.which("tailscale") or "/opt/homebrew/bin/tailscale"

def get_tailscale_status():
    """Checks Tailscale status and returns (is_connected, ip, exit_node)."""
    try:
        # Get status in JSON or parse simple status
        res = subprocess.run([TAILSCALE_PATH, "status"], capture_output=True, text=True)
        is_connected = "Tailscale is stopped" not in res.stderr and res.returncode == 0
        
        if not is_connected:
            return False, "Desconectado", "N/A"
        
        # Get IP
        ip_res = subprocess.run([TAILSCALE_PATH, "ip", "-4"], capture_output=True, text=True)
        ip = ip_res.stdout.strip() or "Desconocida"
        
        return True, ip, "Activo"
    except:
        return False, "Error", "N/A"

def toggle_tailscale(current_status):
    """Proactively toggles Tailscale up or down."""
    try:
        if current_status:
            subprocess.run([TAILSCALE_PATH, "down"], capture_output=True)
            notify("Tailscale", "Cerrando túnel seguro... ¡Vea usted!")
        else:
            subprocess.run([TAILSCALE_PATH, "up"], capture_output=True)
            notify("Tailscale", "Estableciendo conexión segura, mi señor.")
        play_sound("/System/Library/Sounds/Tink.aiff")
    except:
        notify("Tailscale Error", "No se pudo cambiar el estado, ¡qué pues!")

def setup_popup(name, is_connected, ip):
    """Configures the Premium Island popup for Tailscale."""
    sbar_set(name, {
        "popup.background.color": COLORS["ISLAND_BG"],
        "popup.background.border_color": COLORS["ISLAND_BORDER"],
        "popup.background.border_width": 2,
        "popup.background.corner_radius": 10,
        "popup.drawing": "on"
    })

    sbar_set(f"{name}.status", {
        "label": f"Estado: {'Conectado' if is_connected else 'Desconectado'}",
        "icon": "󱔐" if is_connected else "󱔑",
        "icon.color": COLORS["BLUE"] if is_connected else COLORS["RED"],
        "drawing": "on"
    })

    sbar_set(f"{name}.ip", {
        "label": f"IP: {ip}",
        "icon": "󰩟",
        "icon.color": COLORS["CYAN"],
        "drawing": "on" if is_connected else "off"
    })

def main():
    name = os.environ.get("NAME", "tailscale")
    sender = os.environ.get("SENDER", "")
    
    is_connected, ip, _ = get_tailscale_status()

    if sender == "mouse.clicked":
        toggle_tailscale(is_connected)
        # Refresh status after toggle
        is_connected, ip, _ = get_tailscale_status()
        sbar_set(name, {"popup.drawing": "off"})

    if sender == "mouse.entered":
        setup_popup(name, is_connected, ip)
        return
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Update Bar UI
    icon_color = COLORS["BLUE"] if is_connected else COLORS["DIM"]
    sbar_set(name, {
        "icon": "󰖂",
        "icon.color": icon_color,
        "label.drawing": "off"
    })

if __name__ == "__main__":
    main()
