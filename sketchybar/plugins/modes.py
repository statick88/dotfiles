#!/usr/bin/env python3
import os
import subprocess
import json
import time
from utils import COLORS, get_state, save_state, notify, sbar_set

# MODOS PROFESIONALES CONSOLIDADOS (v4.0)
MODES = {
    "normal": {
        "color": COLORS["CYAN"],
        "pomo": {"work": 25 * 60, "short": 5 * 60, "long": 15 * 60}, 
        "label": "Statick",
        "icon": "󰄉",
        "msg": "Modo Statick activado. Entorno de trabajo base listo.",
        "sound": "/System/Library/Sounds/Glass.aiff"
    },
    "student": {
        "color": "0xff00d2ff", # Celeste Llamativo
        "pomo": {"work": 50 * 60, "short": 10 * 60, "long": 20 * 60}, 
        "label": "Estudiante",
        "icon": "🎓",
        "msg": "Modo Estudiante UCM activo. Optimizando para aprendizaje profundo.",
        "sound": "/System/Library/Sounds/Bottle.aiff"
    },
    "facilitator": {
        "color": "0xfff59e0b", # Ámbar
        "pomo": {"work": 25 * 60, "short": 5 * 60, "long": 15 * 60}, 
        "label": "Facilitador",
        "icon": "🤝",
        "msg": "Modo Facilitador activo. Preparado para guiar sesiones de Abacom y Codings.",
        "sound": "/System/Library/Sounds/Pop.aiff"
    },
    "hacking": {
        "color": "0xff10b981", # Verde Hacker
        "pomo": {"work": 90 * 60, "short": 15 * 60, "long": 30 * 60}, 
        "label": "Hacking",
        "icon": "👨‍💻",
        "msg": "Modo Hacking activo. Iniciando protocolos de auditoría y hardening.",
        "sound": "/System/Library/Sounds/Morse.aiff"
    },
    "coding": {
        "color": "0xff38bdf8", # Azul Claro
        "pomo": {"work": 45 * 60, "short": 10 * 60, "long": 20 * 60}, 
        "label": "Coding",
        "icon": "💻",
        "msg": "Modo Coding activo. Ejecutando flujo de desarrollo DevSecOps.",
        "sound": "/System/Library/Sounds/Tink.aiff"
    }
}

DEFAULT_STATE = {"mode": "normal"}

def apply_mode_effects(mode_key, silent=False):
    config = MODES.get(mode_key, MODES["normal"])
    color = config["color"]
    is_normal = (mode_key == "normal")
    
    brackets = ["env", "media", "system", "connectivity", "stats", "pomo"]
    items = ["modes", "front_app", "radio", "battery", "datetime", "volume", "bluetooth", "wifi", "cpu", "ram", "gpu", "disk", "pomodoro"]
    
    batch = ["sketchybar"]
    
    # 1. Update Brackets
    border_color = COLORS["ISLAND_BORDER"] if is_normal else color
    for b in brackets:
        batch.extend([
            "--set", b, f"background.border_color={border_color}",
            "--set", b, "background.border_width=1" if is_normal else "background.border_width=2"
        ])

    # 2. Update Item Colors
    for item in items:
        if not is_normal:
            batch.extend(["--set", item, f"icon.color={color}", f"label.color={color}"])
        else:
            if item == "modes":
                batch.extend(["--set", "modes", f"icon.color={color}", f"label.color={color}"])
            else:
                batch.extend(["--set", item, "icon.color=0xfff3f6f9", "label.color=0xfff3f6f9"])

    # Update global Badge label
    batch.extend(["--set", "modes", f"label={config['label']}"])
    
    subprocess.run(batch)

    # 3. Update Pomodoro State
    pomo_state = get_state("pomodoro", {})
    if pomo_state:
        pomo_state["time_left"] = config["pomo"]["work"]
        pomo_state["active"] = False
        save_state("pomodoro", pomo_state)

    if not silent:
        notify("Perfil Profesional", config["msg"])
        from utils import play_sound
        play_sound(config["sound"])
    
    if is_normal:
        subprocess.run(["sketchybar", "--trigger", "routine", "--trigger", "forced_update"])

def main():
    sender = os.environ.get("SENDER", "")
    action = os.environ.get("ACTION", "")
    state = get_state("modes", DEFAULT_STATE)
    current_mode = state.get("mode", "normal")

    if action == "set_mode":
        new_mode = os.environ.get("MODE_KEY")
        state["mode"] = new_mode
        save_state("modes", state)
        apply_mode_effects(new_mode)
        subprocess.run(["sketchybar", "--set", "modes", "popup.drawing=off"])
        return

    # Regular update
    apply_mode_effects(current_mode, silent=True)

if __name__ == "__main__":
    main()
