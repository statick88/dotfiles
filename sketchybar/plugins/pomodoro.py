#!/usr/bin/env python3
import os
import time
import subprocess
from utils import COLORS, sbar_set, notify, play_sound, get_state, save_state

# Default Fallback (Normal mode)
WORK_TIME = 25 * 60
SHORT_BREAK = 5 * 60
LONG_BREAK = 15 * 60

DEFAULT_STATE = {
    "active": False,
    "time_left": WORK_TIME,
    "session_type": "work",
    "completed_work": 0,
    "total_pomodoros": 0,
    "last_update": time.time(),
}

def get_current_profile_times():
    """Reads times from the active environment mode."""
    try:
        from modes import MODES
        mode_state = get_state("modes", {"mode": "normal"})
        profile = MODES.get(mode_state["mode"], MODES["normal"])
        return profile["pomo"]
    except:
        return {"work": WORK_TIME, "short": SHORT_BREAK, "long": LONG_BREAK}

def get_next_session(state):
    times = get_current_profile_times()
    current_type = state["session_type"]
    
    if current_type == "work":
        state["completed_work"] += 1
        state["total_pomodoros"] += 1
        if state["completed_work"] >= 4:
            state["session_type"] = "long_break"
            state["time_left"] = times["long"]
            state["completed_work"] = 0
            msg = "🍅 ¡Ciclo completado! Tómese un descanso largo, vea usted 🏝️"
        else:
            state["session_type"] = "short_break"
            state["time_left"] = times["short"]
            msg = f"🍅 Sesión {state['completed_work']}/4 terminada. ¡A por un cafecito! 🙌"
    else:
        state["session_type"] = "work"
        state["time_left"] = times["work"]
        msg = "🍅 ¡A camellar se ha dicho! Concentración total 👨‍💻"
    
    notify("Pomodoro", msg)
    play_sound()
    state["active"] = True
    state["last_update"] = time.time()
    return state

def make_progress_bar(current, total, size=15):
    """Creates a visual progress bar for the popup."""
    perc = max(0, min(1, (total - current) / total))
    filled = int(perc * size)
    return "█" * filled + "░" * (size - filled)

def update_popup_contents(name, state, times):
    """Updates the content of the Pomodoro popup without forcing visibility."""
    total_time = times["work"] if state["session_type"] == "work" else (times["long"] if state["session_type"] == "long_break" else times["short"])
    bar = make_progress_bar(state["time_left"], total_time)
    
    if state["session_type"] == "work": icon, phase = "👨‍💻", "TRABAJO"
    elif state["session_type"] == "short_break": icon, phase = "☕", "RECREO"
    else: icon, phase = "🏝️", "DESCANSO"

    # Only update labels and styling, NOT popup.drawing
    sbar_set("pomo.info.type", {"label": f"Fase: {phase}", "icon": icon, "drawing": "on"})
    sbar_set("pomo.info.progress", {"label": f"{bar} {int((1 - state['time_left']/total_time)*100)}%", "drawing": "on"})
    sbar_set("pomo.info.cycle", {"label": f"Sesión: {state['completed_work']}/4", "drawing": "on"})

def main():
    name = os.environ.get("NAME", "pomodoro")
    sender = os.environ.get("SENDER", "")
    action = os.environ.get("ACTION", "")
    now = time.time()

    current_state = get_state("pomodoro", DEFAULT_STATE)
    state = {**DEFAULT_STATE, **current_state}
    times = get_current_profile_times()

    if action == "reset":
        state.update({"active": False, "time_left": times["work"], "session_type": "work", "completed_work": 0})
        save_state("pomodoro", state)
        sbar_set(name, {"popup.drawing": "off"})
        return

    if action == "skip":
        state = get_next_session(state)
        save_state("pomodoro", state)
        sbar_set(name, {"popup.drawing": "off"})
        return

    if sender == "mouse.clicked" and action == "":
        state["active"] = not state["active"]
        state["last_update"] = now
        save_state("pomodoro", state)

    if state["active"]:
        elapsed = now - state["last_update"]
        state["time_left"] = max(0, state["time_left"] - elapsed)
        state["last_update"] = now
        if state["time_left"] <= 0:
            state = get_next_session(state)
        save_state("pomodoro", state)

    # UI HANDLING
    if sender == "mouse.entered":
        # Force styling and visibility ON only when entering
        sbar_set(name, {
            "popup.background.color": COLORS["ISLAND_BG"],
            "popup.background.border_color": COLORS["ISLAND_BORDER"],
            "popup.background.border_width": 2,
            "popup.background.corner_radius": 10,
            "popup.drawing": "on"
        })
        update_popup_contents(name, state, times)
        return
    elif sender == "mouse.exited":
        sbar_set(name, {"popup.drawing": "off"})
        return

    # Regular Bar Update
    mins, secs = divmod(int(state["time_left"]), 60)
    time_str = f"{mins:02d}:{secs:02d}"
    
    if state["session_type"] == "work": color = COLORS["RED"]; bar_icon = "🍅"
    elif state["session_type"] == "short_break": color = COLORS["GREEN"]; bar_icon = "☕"
    else: color = COLORS["BLUE"]; bar_icon = "🏝️"

    icon_to_show = bar_icon if state["active"] else "󰄉"
    active_color = color if state["active"] else COLORS["DIM"]
    
    sbar_set(name, {
        "icon": icon_to_show,
        "icon.color": active_color,
        "label": time_str,
        "label.color": active_color
    })

    # Always update child items in case the popup is open via toggle or sticky hover
    update_popup_contents(name, state, times)

if __name__ == "__main__":
    main()
