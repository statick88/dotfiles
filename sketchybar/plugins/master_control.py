#!/usr/bin/env python3
import subprocess
import os
import sys

# Rutas de los plugins
PLUGIN_DIR = "/Users/statick/.config/sketchybar/plugins"
MUSIC_PLUGIN = f"{PLUGIN_DIR}/music.py"
RADIO_PLUGIN = f"{PLUGIN_DIR}/radio.py"

def toggle_all():
    # 1. Intentar pausar Spotify
    subprocess.run(["osascript", "-e", 'if application "Spotify" is running then tell application "Spotify" to playpause'], capture_output=True)
    
    # 2. Toggle Radio (envía evento de clic al plugin)
    env = os.environ.copy()
    env["SENDER"] = "mouse.clicked"
    subprocess.run([RADIO_PLUGIN], env=env, capture_output=True)

def volume_up():
    subprocess.run(["osascript", "-e", "set volume output volume ((output volume of (get volume settings)) + 5)"], capture_output=True)
    # Forzar actualización de la barra
    subprocess.run(["sketchybar", "--trigger", "volume_change"], capture_output=True)

def volume_down():
    subprocess.run(["osascript", "-e", "set volume output volume ((output volume of (get volume settings)) - 5)"], capture_output=True)
    # Forzar actualización de la barra
    subprocess.run(["sketchybar", "--trigger", "volume_change"], capture_output=True)

def toggle_mute():
    subprocess.run(["osascript", "-e", "set volume with output muted"], capture_output=True)
    subprocess.run(["sketchybar", "--trigger", "volume_change"], capture_output=True)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd == "up":
            volume_up()
        elif cmd == "down":
            volume_down()
        elif cmd == "mute":
            toggle_mute()
    else:
        toggle_all()
