#!/usr/bin/env python3
import os
import time
import subprocess
from utils import COLORS, sbar_set, notify, play_sound, get_state, save_state

WORK_TIME = 25 * 60
SHORT_BREAK = 5 * 60
LONG_BREAK = 15 * 60

DEFAULT_STATE = {
    "active": False,
    "time_left": WORK_TIME,
    "session_type": "work",
    "work_sessions_completed": 0,
    "last_update": time.time()
}

def get_next_session(state):
    if state.get("session_type", "work") == "work":
        state["work_sessions_completed"] = state.get("work_sessions_completed", 0) + 1
        if state["work_sessions_completed"] >= 4:
            state.update({"session_type": "long_break", "time_left": LONG_BREAK, "work_sessions_completed": 0})
        else:
            state.update({"session_type": "short_break", "time_left": SHORT_BREAK})
    else:
        state.update({"session_type": "work", "time_left": WORK_TIME})
    return state

def main():
    name = os.environ.get("NAME", "pomodoro")
    sender = os.environ.get("SENDER", "")
    
    # Cargar estado seguro
    raw_state = get_state("pomodoro", DEFAULT_STATE)
    state = {**DEFAULT_STATE, **raw_state}
    
    now = time.time()

    if sender == "mouse.clicked":
        state["active"] = not state.get("active", False)
        if state["time_left"] <= 0: 
            state = get_next_session(state)
        state["last_update"] = now
        save_state("pomodoro", state)

    if state.get("active", False):
        elapsed = now - state.get("last_update", now)
        state["time_left"] = max(0, state.get("time_left", WORK_TIME) - elapsed)
        state["last_update"] = now
        
        if state["time_left"] <= 0:
            state["active"] = False
            state = get_next_session(state)
            save_state("pomodoro", state)
            play_sound()
            msg = "¡A trabajar! 🍅" if state["session_type"] == "work" else "¡Tómate un descanso! ☕"
            notify("Pomodoro", msg)
        else:
            save_state("pomodoro", state)

    mins, secs = divmod(int(state.get("time_left", WORK_TIME)), 60)
    time_str = f"{mins:02d}:{secs:02d}"
    
    # MODO MINIMALISTA: Quitar el "(Off)"
    if not state.get("active", False):
        color, label = COLORS["DIM"], f"🍅 {time_str}"
    else:
        if state.get("session_type", "work") == "work":
            color = COLORS["RED"] if state["time_left"] <= 60 else COLORS["WHITE"]
        else:
            color = COLORS["GREEN"]
        label = f"🍅 {time_str}"

    subprocess.run(["sketchybar", "--set", name, f"label={label}", f"label.color={color}"])

if __name__ == "__main__":
    main()
