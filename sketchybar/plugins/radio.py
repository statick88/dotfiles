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
    "boqueron": {"name": "Boquerón FM", "stream": "https://stream.hospedandosites.com.br:8038/stream", "city": "Loja"},
    "macara": {"name": "Stereo Macará", "stream": "https://stream.zeno.fm/k1tea505d8zuv", "city": "Loja"},
    "luzyvida": {"name": "Luz y Vida", "stream": "https://sonicpanel.zonaradio.net/8280/stream", "city": "Loja"},
    "matovelle": {"name": "Matovelle", "stream": "https://radiomatovelle.com:8000/stream", "city": "Loja"},
    "podocarpus": {"name": "Podocarpus", "stream": "http://ecuamedios.net:8889/;", "city": "Loja"},
    "canela_uio": {"name": "Canela Quito", "stream": "http://canelaradio.makrodigital.com:9250/stream", "city": "Quito"},
    "fmmundo": {"name": "FM Mundo", "stream": "http://streamingecuador.com:8066/stream", "city": "Quito"},
    "lared": {"name": "La Red", "stream": "https://stream.lared.am/lared", "city": "Quito"},
    "caravana": {"name": "Caravana", "stream": "http://192.99.148.184:9310/stream", "city": "Guayaquil"},
    "diblu": {"name": "Radio Diblu", "stream": "http://www.aacplus.ec:8050/stream", "city": "Guayaquil"},
    "canela_gye": {"name": "Canela GYE", "stream": "http://canelaradio.makrodigital.com:9250/stream", "city": "Guayaquil"},
    "tomebamba": {"name": "La Voz Tomebamba", "stream": "http://192.99.148.184:9314/stream", "city": "Cuenca"},
    "sonido": {"name": "Sonido 102.1", "stream": "http://198.50.156.92:8215/stream", "city": "Cuenca"},
}

def pause_spotify():
    subprocess.run(["osascript", "-e", 'if application "Spotify" is running then tell application "Spotify" to pause'], capture_output=True)

def stop_radio():
    subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)

def play_radio(url):
    stop_radio()
    subprocess.Popen([FFPLAY_PATH, "-nodisp", "-loglevel", "quiet", "-autoexit", url], 
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def update_ui(state):
    name = os.environ.get("NAME", "radio")
    station = STATIONS.get(state["current"], STATIONS["exa"])
    label = f"{station['name']}" if state["playing"] else f"{station['name']} (Off)"
    color = COLORS["GREEN"] if state["playing"] else COLORS["DIM"]
    sbar_set(name, {"label": label, "icon.color": color})

def handle_click():
    state = read_state()
    station_arg = os.environ.get("STATION", "")

    if station_arg in STATIONS:
        # Clic en una estación del menú
        pause_spotify()
        state.update({"current": station_arg, "playing": True})
        play_radio(STATIONS[station_arg]["stream"])
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        # Clic en el item principal: Toggle Popup + Auto-close timer
        res = subprocess.run(["sketchybar", "--query", "radio"], capture_output=True, text=True)
        is_open = "on" in res.stdout.split("popup.drawing=")[1].split("\n")[0]
        
        if is_open:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
        else:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=on"])
            # Iniciar timer de 5 segundos en segundo plano para cerrar
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
        # Cerrar inmediatamente si el ratón sale
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        state = read_state()
        update_ui(state)
