#!/usr/bin/env python3
import subprocess
import os
import re
import shutil
from utils import COLORS, sbar_set, get_state, save_state, notify


def get_battery_info(pmset_output=None, ioreg_output=None):
    """Parses pmset and ioreg for detailed battery stats."""
    if pmset_output is None:
        try:
            res = subprocess.run(["pmset", "-g", "batt"], capture_output=True, text=True)
            pmset_output = res.stdout
        except Exception:
            pmset_output = ""

    if ioreg_output is None:
        try:
            res = subprocess.run(["ioreg", "-rk", "AppleSmartBattery"], capture_output=True, text=True)
            ioreg_output = res.stdout
        except Exception:
            ioreg_output = ""

    try:
        # PMSET Parsing
        percentage_match = re.search(r"(\d+)%", pmset_output)
        percentage = int(percentage_match.group(1)) if percentage_match else 0
        
        # Exact word matching for charging to avoid "discharging" false positive
        is_charging = any(re.search(rf"\b{x}\b", pmset_output) for x in ["charging", "AC Power", "attached"])
        
        time_match = re.search(r"(\d+:\d+) remaining", pmset_output)
        time_rem = time_match.group(1) if time_match else "Calculando..."
        condition = "Normal" if "condition: Normal" in pmset_output else "Mantenimiento"
            
        if is_charging and "0:00" in time_rem:
            time_rem = "Cargada"

        # IOREG Parsing for cycles
        cycles_match = re.search(r'"CycleCount"\s*=\s*(\d+)', ioreg_output)
        cycles = int(cycles_match.group(1)) if cycles_match else 0
            
        return percentage, is_charging, time_rem, condition, cycles
    except Exception:
        return 0, False, "N/A", "N/A", 0


def get_battery_ui(percentage, is_charging):
    """Returns icon and color based on status."""
    if is_charging:
        return "󱐋", COLORS["YELLOW"]

    if percentage <= 10:
        return "󰂃", COLORS["RED"]
    elif percentage <= 20:
        return "󰁺", COLORS["RED"]
    elif percentage <= 30:
        return "󰁻", COLORS["ORANGE"]
    elif percentage <= 50:
        return "󰁽", COLORS["YELLOW"]
    elif percentage <= 70:
        return "󰁿", COLORS["GREEN"]
    elif percentage <= 90:
        return "󰂁", COLORS["GREEN"]
    else:
        return "󰁹", COLORS["GREEN"]


def get_health_alert(percentage, is_charging, state):
    """Determines health notifications and power source changes."""
    last_alert = state.get("last_alert")
    last_charging = state.get("last_charging")
    
    # 1. Power Source Change Detection
    if last_charging is not None:
        if is_charging and not last_charging:
            notify("⚡ Cargador Conectado", "Su Mac ahora tiene energía constante, vea usted.")
        elif not is_charging and last_charging:
            notify("🔋 Usando Batería", "Ya le quitó el cable, ¡qué pues!")
    
    # 2. Level Alerts
    if is_charging:
        if percentage == 100 and last_alert != "full":
            return "full", ("✅ Carga Completa", "¡Vea usted! Batería al 100%. Desconecte el cargador para cuidar la salud 🔋")
        elif percentage < 100:
            return "charging", None
        return last_alert, None

    if percentage <= 5:
        if last_alert != "emergency":
            return "emergency", ("🚨 EMERGENCIA: Batería al 5%", "¡Apague toditito ya! Conecte el cargador AHORA ⚡")
    elif percentage <= 10:
        if last_alert not in ["critical", "emergency"]:
            return "critical", ("🚨 CRÍTICO: Batería al 10%", "¡Último aviso, vea! Conecte el cargador inmediatamente 🔌⚡")
    elif percentage <= 20:
        if last_alert not in ["low", "critical", "emergency"]:
            return "low", ("⚠️ Peligro Batería", "Busque su cargador y una fuente de luz, ¡qué pues! ⚡")
    elif percentage > 30:
        return "safe", None
    return last_alert, None


def setup_popup(name, percentage, is_charging, time_rem, condition, cycles):
    """Configures the Premium Island popup."""
    sbar_set(name, {
        "popup.background.color": COLORS["ISLAND_BG"],
        "popup.background.border_color": COLORS["ISLAND_BORDER"],
        "popup.background.border_width": 2,
        "popup.background.corner_radius": 10,
        "popup.background.padding_left": 10,
        "popup.background.padding_right": 10,
        "popup.drawing": "on"
    })

    # Detailed items in popup
    sbar_set(f"{name}.state", {
        "label": f"Estado: {'Cargando' if is_charging else 'Descargando'}",
        "icon": "󱐋" if is_charging else "󰚥",
        "icon.color": COLORS["YELLOW"] if is_charging else COLORS["DIM"],
        "label.padding_left": 10
    })
    sbar_set(f"{name}.health", {
        "label": f"Salud: {condition}",
        "icon": "󰂑",
        "icon.color": COLORS["GREEN"] if condition == "Normal" else COLORS["RED"],
        "label.padding_left": 10
    })
    sbar_set(f"{name}.time", {
        "label": f"Restante: {time_rem}",
        "icon": "󱑂",
        "icon.color": COLORS["BLUE"],
        "label.padding_left": 10
    })
    sbar_set(f"{name}.cycles", {
        "label": f"Ciclos: {cycles}",
        "icon": "󰑖",
        "icon.color": COLORS["MAGENTA"],
        "label.padding_left": 10
    })


def main():
    name = os.environ.get("NAME", "battery")
    sender = os.environ.get("SENDER")
    state = get_state("battery_alerts", {"last_alert": None, "last_charging": None})

    percentage, is_charging, time_rem, condition, cycles = get_battery_info()
    icon, color = get_battery_ui(percentage, is_charging)
    
    # --- Handle Click ---
    if sender == "mouse.clicked":
        subprocess.run(["open", "x-apple.systempreferences:com.apple.Battery-Settings.extension"])
        return

    # --- Handle Hover ---
    if sender == "mouse.entered":
        sbar_set(name, {
            "label": time_rem,
            "icon.color": COLORS["WHITE"]
        })
        setup_popup(name, percentage, is_charging, time_rem, condition, cycles)
        return
    elif sender == "mouse.exited":
        sbar_set(name, {
            "label": f"{percentage}%",
            "icon.color": color,
            "popup.drawing": "off"
        })
        return

    # --- Normal Update ---
    new_alert_type, alert_data = get_health_alert(percentage, is_charging, state)
    
    if alert_data:
        notify(alert_data[0], alert_data[1])
    
    # Update and save state
    state["last_alert"] = new_alert_type
    state["last_charging"] = is_charging
    save_state("battery_alerts", state)

    sbar_set(name, {
        "label": f"{percentage}%",
        "icon": icon,
        "icon.color": color
    })


if __name__ == "__main__":
    main()
