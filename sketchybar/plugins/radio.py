#!/usr/bin/env python3
import subprocess
import os
import json
import time
import sys
from utils import COLORS, sbar_set, get_state, save_state

FFPLAY_PATH = "/opt/homebrew/bin/ffplay"

STATIONS = {
    "exa": {"name": "EXA FM", "stream": "https://26573.live.streamtheworld.com/ECUADORAAC.aac", "city": "Quito"},
    "airelatino": {"name": "Aire Latino 88.5", "stream": "https://stream.airelatino.es/stream", "city": "Valencia, ES"},
    "boqueron": {"name": "Boquerón FM", "city": "Loja", "stream": "https://stream.hospedandosites.com.br:8038/stream"},
    "macara": {"name": "Stereo Macará", "city": "Loja", "stream": "https://stream.zeno.fm/k1tea505d8zuv"},
    "luzyvida": {"name": "Luz y Vida", "city": "Loja", "stream": "https://sonicpanel.zonaradio.net/8280/stream"},
    "matovelle": {"name": "Matovelle", "city": "Loja", "stream": "https://radiomatovelle.com:8000/stream"},
    "podocarpus": {"name": "Podocarpus", "city": "Loja", "stream": "http://ecuamedios.net:8889/;"},
    "canela_uio": {"name": "Canela Quito", "city": "Quito", "stream": "http://canelaradio.makrodigital.com:9250/stream"},
    "fmmundo": {"name": "FM Mundo", "city": "Quito", "stream": "http://streamingecuador.com:8066/stream"},
    "lared": {"name": "La Red", "city": "Quito", "stream": "https://stream.lared.am/lared"},
    "caravana": {"name": "Caravana", "city": "Guayaquil", "stream": "http://192.99.148.184:9310/stream"},
    "diblu": {"name": "Radio Diblu", "city": "Guayaquil", "stream": "http://www.aacplus.ec:8050/stream"},
    "canela_gye": {"name": "Canela GYE", "city": "Guayaquil", "stream": "http://canelaradio.makrodigital.com:9250/stream"},
    "tomebamba": {"name": "La Voz Tomebamba", "city": "Cuenca", "stream": "http://192.99.148.184:9314/stream"},
    "sonido": {"name": "Sonido 102.1", "city": "Cuenca", "stream": "http://198.50.156.92:8215/stream"},
}

def pause_spotify():
    """Pauses Spotify via osascript to avoid audio overlap."""
    subprocess.run(["osascript", "-e", 'if application "Spotify" is running then tell application "Spotify" to pause'], capture_output=True)

def stop_radio():
    """Kills any running ffplay processes to stop current radio."""
    subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)

def play_radio(url):
    """Starts ffplay in background with optimized settings."""
    stop_radio()
    # Using -autoexit and -nodisp for a clean background stream
    subprocess.Popen([FFPLAY_PATH, "-nodisp", "-loglevel", "quiet", "-autoexit", url], 
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def update_ui(state):
    name = os.environ.get("NAME", "radio")
    station = STATIONS.get(state["current"], STATIONS["exa"])
    label = f"{station['name']}" if state["playing"] else f"{station['name']} (Off)"
    color = COLORS["ORANGE"] if state["playing"] else COLORS["DIM"]
    sbar_set(name, {"label": label, "icon.color": color})

def handle_click():
    state = read_state()
    station_arg = os.environ.get("STATION", "")

    if station_arg in STATIONS:
        # User picked a specific station from the menu
        pause_spotify()
        state.update({"current": station_arg, "playing": True})
        play_radio(STATIONS[station_arg]["stream"])
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        # Main item click: toggle popup visibility
        res = subprocess.run(["sketchybar", "--query", "radio"], capture_output=True, text=True)
        is_open = "on" in res.stdout.split("popup.drawing=")[1].split("\n")[0]
        
        if is_open:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
        else:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=on"])
            # Auto-close after 5 seconds
            subprocess.Popen(["bash", "-c", "sleep 5 && sketchybar --set radio popup.drawing=off"])
            
    save_state("radio", state)
    update_ui(state)

def read_state():
    return get_state("radio", {"playing": False, "current": "exa"})

if __name__ == "__main__":
    sender = os.environ.get("SENDER", "")
    
    if sender == "mouse.clicked":
        handle_click()
    elif sender == "mouse.exited":
        # Immediate close when mouse leaves the area
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        state = read_state()
        update_ui(state)
