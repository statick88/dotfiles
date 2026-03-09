#!/usr/bin/env python3
import subprocess
import os
from utils import COLORS, sbar_set, get_state, save_state

def notify(title, message):
    """Sends a native macOS notification."""
    cmd = f'display notification "{message}" with title "{title}" sound name "Glass"'
    subprocess.run(["osascript", "-e", cmd])

def main():
    name = os.environ.get("NAME", "battery")
    state = get_state("battery_alerts", {"last_alert": None})
    
    # Get battery data
    res = subprocess.run(["pmset", "-g", "batt"], capture_output=True, text=True)
    out = res.stdout
    
    try:
        percentage = int(out.split("%")[0].split()[-1])
        charging = "charging" in out or "AC Power" in out or "attached" in out
    except:
        percentage = 0
        charging = False

    # 1. ALERT LOGIC (Multilevel Health)
    current_alert = None
    
    if charging:
        if percentage == 100:
            current_alert = "full"
            if state["last_alert"] != "full":
                notify("✅ Carga Completa", "Desconecta el cargador para proteger la vida útil 🔋")
        else:
            current_alert = "charging" # Reset when charging
    else:
        # Discharge states
        if percentage <= 10:
            current_alert = "critical"
            if state["last_alert"] != "critical":
                notify("🚨 CRÍTICO: Batería al 10%", "¡Último aviso! Conecta el cargador inmediatamente 🔌⚡")
        elif percentage <= 20:
            current_alert = "low"
            if state["last_alert"] != "low" and state["last_alert"] != "critical":
                notify("⚠️ Peligro Batería", "Busca tu cargador y una fuente de electricidad ⚡")
        elif 30 < percentage < 90:
            current_alert = "safe"

    # Only save if the state changed to avoid writing every minute
    if current_alert != state["last_alert"]:
        state["last_alert"] = current_alert
        save_state("battery_alerts", state)

    # 2. UI LOGIC (Icons and Colors)
    if charging:
        icon = "󱐋"
        color = COLORS["YELLOW"]
    else:
        color = COLORS["GREEN"]
        if percentage <= 10: icon, color = "󰂃", COLORS["RED"]
        elif percentage <= 20: icon, color = "󰁺", COLORS["RED"]
        elif percentage <= 30: icon = "󰁻"
        elif percentage <= 40: icon = "󰁼"
        elif percentage <= 50: icon = "󰁽"
        elif percentage <= 60: icon = "󰁾"
        elif percentage <= 70: icon = "󰁿"
        elif percentage <= 80: icon = "󰂀"
        elif percentage <= 90: icon = "󰂁"
        else: icon = "󰁹"
        
    sbar_set(name, {
        "label": f"{percentage}%",
        "icon": icon,
        "icon.color": color
    })

if __name__ == "__main__":
    main()
