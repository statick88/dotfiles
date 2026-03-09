#!/usr/bin/env python3
import subprocess
import os
import json

# GENTLEMAN COLOR PALETTE
COLORS = {
    "BLACK": "0xff06080f",
    "WHITE": "0xfff3f6f9",
    "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85",
    "YELLOW": "0xffffe066",
    "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca",
    "MAGENTA": "0xffff8dd7",
    "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000",
    "ISLAND_BG": "0xff121620",
    "ISLAND_BORDER": "0xff263356",
    "ACCENT": "0xffe0c15a",
    "DIM": "0xff565f89"
}

STATE_DIR = os.path.expanduser("~/.config/sketchybar/state")

def sbar_set(name, properties):
    args = ["sketchybar", "--set", name]
    for prop, value in properties.items():
        args.append(f"{prop}={value}")
    subprocess.run(args, capture_output=True)

def notify(title, message):
    subprocess.Popen(["osascript", "-e", f'display notification "{message}" with title "{title}"'])

def play_sound(file="/System/Library/Sounds/Glass.aiff"):
    subprocess.Popen(["afplay", file], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def get_state(plugin_name, default):
    path = os.path.join(STATE_DIR, f"{plugin_name}.json")
    if not os.path.exists(path): return default
    try:
        with open(path, "r") as f: return json.load(f)
    except: return default

def save_state(plugin_name, state):
    path = os.path.join(STATE_DIR, f"{plugin_name}.json")
    try:
        with open(path, "w") as f: json.dump(state, f)
    except: pass
