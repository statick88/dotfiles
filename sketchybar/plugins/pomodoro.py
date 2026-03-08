#!/usr/bin/env python3
import subprocess
import os
import time
import json

STATE_FILE = os.path.expanduser("~/.pomodoro.json")

WORK_TIME = 25 * 60  # 25 minutos de trabajo
SHORT_BREAK = 5 * 60  # 5 minutos de descanso corto
LONG_BREAK = 15 * 60  # 15 minutos de descanso largo
CYCLES_BEFORE_LONG = 3  # Descansos largos después de 3 ciclos de trabajo

ICON_WORK = "🍅"
ICON_SHORT_BREAK = "☕"
ICON_LONG_BREAK = "🌙"

COLOR_DEFAULT = "0xffffffff"  # Blanco para pomodoro
COLOR_WARNING = "0xffd75f5f"  # Rojo para alerta
COLOR_BREAK = "0xffffffff"  # Blanco para descanso

SOUND_FILE = "/System/Library/Sounds/Glass.aiff"


def play_sound():
    try:
        subprocess.run(["afplay", SOUND_FILE], capture_output=True, timeout=2)
    except Exception:
        pass


def read_state():
    if not os.path.exists(STATE_FILE):
        return {
            "active": False,
            "time_left": WORK_TIME,
            "session_type": "work",
            "work_sessions_completed": 0,
            "last_update": time.time(),
            "warning_played": False,
        }

    try:
        with open(STATE_FILE, "r") as f:
            return json.load(f)
    except Exception:
        return {
            "active": False,
            "time_left": WORK_TIME,
            "session_type": "work",
            "work_sessions_completed": 0,
            "last_update": time.time(),
            "warning_played": False,
        }


def save_state(state):
    try:
        with open(STATE_FILE, "w") as f:
            json.dump(state, f)
    except Exception:
        pass


def send_notification(title, message):
    try:
        subprocess.run(
            [
                "osascript",
                "-e",
                f'display notification "{message}" with title "{title}"',
            ]
        )
    except Exception:
        pass


def get_next_session(state, play_session_complete_sound=False):
    if state["session_type"] == "work":
        state["work_sessions_completed"] += 1

        if state["work_sessions_completed"] >= 4:
            state["session_type"] = "long_break"
            state["time_left"] = LONG_BREAK
            state["work_sessions_completed"] = 0
            state["warning_played"] = False
            if play_session_complete_sound:
                play_sound()  # SOUND #2: Session complete (4 cycles done)
            send_notification(
                "🍅 Pomodoro", "¡4 ciclos completados! Descanso largo de 15 minutos 🌙"
            )
        else:
            state["session_type"] = "short_break"
            state["time_left"] = SHORT_BREAK
            state["warning_played"] = False
            send_notification(
                "🍅 Pomodoro", "¡Tiempo de trabajo completado! Descanso de 5 minutos ☕"
            )
    else:
        state["session_type"] = "work"
        state["time_left"] = WORK_TIME
        state["warning_played"] = False
        send_notification("☕ Descanso terminado", "¡A trabajar! 🍅")

    return state


def main():
    name = os.environ.get("NAME", "pomodoro")
    sender = os.environ.get("SENDER", "")

    state = read_state()

    if sender == "mouse.clicked":
        if not state["active"]:
            state["active"] = True
            if state["time_left"] <= 0:
                state = get_next_session(state)
        else:
            state["active"] = False
        state["last_update"] = time.time()
        save_state(state)

    if state["active"]:
        current_time = time.time()
        elapsed = current_time - state["last_update"]
        state["time_left"] = max(0, state["time_left"] - elapsed)
        state["last_update"] = current_time

        # ONLY play sound when period ends (time_left <= 0)
        if state["time_left"] <= 0:
            play_sound()  # SOUND #1: Period end bell
            state = get_next_session(state, play_session_complete_sound=True)
            state["last_update"] = current_time

        save_state(state)

    mins = int(state["time_left"] // 60)
    secs = int(state["time_left"] % 60)
    time_str = f"{mins:02d}:{secs:02d}"

    if state["session_type"] == "work":
        icon = ""
        color = COLOR_DEFAULT
        if state["time_left"] <= 60 and state["active"]:
            color = COLOR_WARNING
    elif state["session_type"] == "short_break":
        icon = ""
        color = COLOR_BREAK
        if state["time_left"] <= 10 and state["active"]:
            color = COLOR_WARNING
    else:
        icon = ""
        color = COLOR_BREAK
        if state["time_left"] <= 10 and state["active"]:
            color = COLOR_WARNING

    label = f"🍅 {time_str}"

    subprocess.run(
        ["sketchybar", "--set", name, f"label={label}", f"label.color={color}"]
    )


if __name__ == "__main__":
    main()
