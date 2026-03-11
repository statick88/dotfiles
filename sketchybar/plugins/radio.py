#!/usr/bin/env python3
import subprocess
import os
import json
import time
import sys
import urllib.request
import socket
from utils import COLORS, sbar_set, get_state, save_state

FFPLAY_PATH = "/opt/homebrew/bin/ffplay"

STATIONS = {
    "exa": {
        "name": "EXA FM",
        "stream": "https://26573.live.streamtheworld.com/ECUADORAAC.aac",
        "city": "Quito",
    },
    "airelatino": {
        "name": "Aire Latino 88.5",
        "stream": "https://stream.airelatino.es/stream",
        "city": "Valencia, ES",
    },
    "boqueron": {
        "name": "Boquerón FM",
        "city": "Loja",
        "stream": "https://stream.hospedandosites.com.br:8038/stream",
    },
    "macara": {
        "name": "Stereo Macará",
        "city": "Loja",
        "stream": "https://stream.zeno.fm/k1tea505d8zuv",
    },
    "luzyvida": {
        "name": "Luz y Vida",
        "city": "Loja",
        "stream": "https://sonicpanel.zonaradio.net/8280/stream",
    },
    "matovelle": {
        "name": "Matovelle",
        "city": "Loja",
        "stream": "https://radiomatovelle.com:8000/stream",
    },
    "podocarpus": {
        "name": "Podocarpus",
        "city": "Loja",
        "stream": "http://ecuamedios.net:8889/;",
    },
    "canela_uio": {
        "name": "Canela Quito",
        "city": "Quito",
        "stream": "http://canelaradio.makrodigital.com:9250/stream",
    },
    "fmmundo": {
        "name": "FM Mundo",
        "city": "Quito",
        "stream": "http://streamingecuador.com:8066/stream",
    },
    "lared": {
        "name": "La Red",
        "city": "Quito",
        "stream": "https://stream.lared.am/lared",
    },
    "caravana": {
        "name": "Caravana",
        "city": "Guayaquil",
        "stream": "http://192.99.148.184:9310/stream",
    },
    "diblu": {
        "name": "Radio Diblu",
        "city": "Guayaquil",
        "stream": "http://www.aacplus.ec:8050/stream",
    },
    "canela_gye": {
        "name": "Canela GYE",
        "city": "Guayaquil",
        "stream": "http://canelaradio.makrodigital.com:9250/stream",
    },
    "tomebamba": {
        "name": "La Voz Tomebamba",
        "city": "Cuenca",
        "stream": "http://192.99.148.184:9314/stream",
    },
    "sonido": {
        "name": "Sonido 102.1",
        "city": "Cuenca",
        "stream": "http://198.50.156.92:8215/stream",
    },
}


def pause_spotify():
    """Pauses Spotify via osascript to avoid audio overlap."""
    subprocess.run(
        [
            "osascript",
            "-e",
            'if application "Spotify" is running then tell application "Spotify" to pause',
        ],
        capture_output=True,
    )


def stop_radio():
    """Kills any running ffplay processes to stop current radio."""
    subprocess.run(["pkill", "-f", "ffplay.*nodisp"], capture_output=True)


def is_ffplay_available():
    """Check if ffplay is installed and available in the system path."""
    try:
        subprocess.run([FFPLAY_PATH, "-version"], capture_output=True, check=True)
        return True
    except FileNotFoundError:
        return False
    except subprocess.CalledProcessError:
        return False


def validate_stream(url, timeout=5):
    """Validates that a stream URL is reachable and returns audio content, or that a local file exists and is readable."""
    # Check if it's a local file (starts with file:// or is a regular file path)
    if url.startswith("file://"):
        local_path = url[7:]  # Strip "file://" prefix
    elif os.path.exists(url):
        local_path = url
    else:
        # Not a local file, treat as remote URL
        try:
            socket.setdefaulttimeout(timeout)
            with urllib.request.urlopen(url, timeout=timeout) as response:
                content_type = response.headers.get("Content-Type", "")
                return response.status == 200 and (
                    "audio" in content_type or "mpeg" in content_type
                )
        except Exception:
            return False

    # Check if local file exists and is readable
    try:
        if os.path.isfile(local_path) and os.access(local_path, os.R_OK):
            # Check if it's a audio file (by extension)
            audio_extensions = [".mp3", ".aac", ".flac", ".ogg", ".wav", ".m4a"]
            return any(local_path.lower().endswith(ext) for ext in audio_extensions)
        return False
    except Exception:
        return False


def play_radio(url):
    """Starts ffplay in background with optimized settings."""
    if not is_ffplay_available():
        print("Error: ffplay not found at /opt/homebrew/bin/ffplay", file=sys.stderr)
        return False

    if not validate_stream(url):
        print(f"Error: Invalid stream URL - {url}", file=sys.stderr)
        return False

    stop_radio()
    # Using -autoexit and -nodisp for a clean background stream
    try:
        subprocess.Popen(
            [FFPLAY_PATH, "-nodisp", "-loglevel", "quiet", "-autoexit", url],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return True
    except Exception as e:
        print(f"Error playing radio: {e}", file=sys.stderr)
        return False


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
        success = play_radio(STATIONS[station_arg]["stream"])
        state.update({"current": station_arg, "playing": success})
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        # Main item click: toggle popup visibility
        res = subprocess.run(
            ["sketchybar", "--query", "radio"], capture_output=True, text=True
        )
        is_open = "on" in res.stdout.split("popup.drawing=")[1].split("\n")[0]

        if is_open:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
        else:
            subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=on"])
            # Auto-close after 5 seconds
            subprocess.Popen(
                ["bash", "-c", "sleep 5 && sketchybar --set radio popup.drawing=off"]
            )

    save_state("radio", state)
    update_ui(state)


def read_state():
    return get_state("radio", {"playing": False, "current": "exa"})


def main():
    sender = os.environ.get("SENDER", "")

    if sender == "mouse.clicked":
        handle_click()
    elif sender == "mouse.exited":
        # Immediate close when mouse leaves the area
        subprocess.run(["sketchybar", "--set", "radio", "popup.drawing=off"])
    else:
        state = read_state()
        update_ui(state)


if __name__ == "__main__":
    main()
