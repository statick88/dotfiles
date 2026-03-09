#!/usr/bin/env python3
import subprocess
import os
import sys
import json

def get_window_info(window_id):
    try:
        result = subprocess.run(["yabai", "-m", "query", "--windows", "--window", str(window_id)], capture_output=True, text=True)
        return json.loads(result.stdout)
    except:
        return None

def get_space_info(space_index):
    try:
        result = subprocess.run(["yabai", "-m", "query", "--spaces", "--space", str(space_index)], capture_output=True, text=True)
        return json.loads(result.stdout)
    except:
        return None

def handle_window_created():
    # When a window is created, move it to a new space
    try:
        # 1. Create a new space
        subprocess.run(["yabai", "-m", "space", "--create"], capture_output=True)
        
        # 2. Get the index of the newly created space (which is the last one)
        spaces = json.loads(subprocess.run(["yabai", "-m", "query", "--spaces"], capture_output=True, text=True).stdout)
        last_space_index = spaces[-1]["index"]
        
        # 3. Get the ID of the window that was just created
        # SketchyBar passes INFO which might contain the window id depending on the event
        # Alternatively, get the currently focused window which is usually the new one
        focused_window = json.loads(subprocess.run(["yabai", "-m", "query", "--windows", "--window"], capture_output=True, text=True).stdout)
        window_id = focused_window["id"]
        
        # 4. Move window to the new space and focus it
        subprocess.run(["yabai", "-m", "window", str(window_id), "--space", str(last_space_index)], capture_output=True)
        subprocess.run(["yabai", "-m", "space", "--focus", str(last_space_index)], capture_output=True)
    except Exception as e:
        with open("/tmp/yabai_debug.log", "a") as f:
            f.write(f"Error in handle_window_created: {str(e)}\n")

def handle_window_moved():
    # If a window is moved to a space with other windows, ensure column layout
    try:
        focused_window = json.loads(subprocess.run(["yabai", "-m", "query", "--windows", "--window"], capture_output=True, text=True).stdout)
        current_space_index = focused_window["space"]
        
        # Count windows in current space
        windows_in_space = json.loads(subprocess.run(["yabai", "-m", "query", "--windows", "--space", str(current_space_index)], capture_output=True, text=True).stdout)
        
        if len(windows_in_space) > 1:
            # Set layout to bsp (managed tiling) which handles columns/splits
            # If the user specifically wants "columns", we can force vertical splits
            subprocess.run(["yabai", "-m", "space", "--layout", "bsp"], capture_output=True)
            # You can add more logic here to force specific column behavior if bsp default isn't enough
    except Exception as e:
        pass

if __name__ == "__main__":
    sender = os.environ.get("SENDER", "")
    
    if sender == "yabai_window_created":
        # Small delay to ensure yabai has registered the window
        time_sleep = 0.1
        import time
        time.sleep(time_sleep)
        handle_window_created()
    elif sender == "yabai_window_moved":
        handle_window_moved()
