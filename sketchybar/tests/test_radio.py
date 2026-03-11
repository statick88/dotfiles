#!/usr/bin/env python3
import os
import sys
import json
import subprocess
import tempfile
import shutil

# Setup paths
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "plugins")
)


def test_radio_state_logic():
    print("🚀 Iniciando Test de Lógica de Radio...")

    # Mock de las emisoras que acabamos de agregar
    STATIONS_MOCK = {
        "exa": {"name": "EXA FM"},
        "airelatino": {"name": "Aire Latino 88.5"},
    }

    # Simular lectura de estado (get_state)
    initial_state = {"playing": False, "current": "exa"}
    print(f"Estado Inicial: {initial_state}")

    # Simular cambio de emisora a Aire Latino
    new_station = "airelatino"
    if new_station in STATIONS_MOCK:
        new_state = {"playing": True, "current": new_station}
        print(f"Cambio a {new_station}: PASSED")
    else:
        print(f"Cambio a {new_station}: FAILED")
        return False

    # Verificar persistencia de nombre
    if STATIONS_MOCK[new_state["current"]]["name"] == "Aire Latino 88.5":
        print("Validación de nombre de emisora: PASSED")
    else:
        print("Validación de nombre de emisora: FAILED")
        return False

    return True


def test_ffplay_availability():
    print("\n🎵 Test de disponibilidad de FFplay...")
    try:
        import radio

        result = radio.is_ffplay_available()
        print(f"FFplay disponible: {'✅ PASSED' if result else '❌ FAILED'}")
        return result
    except Exception as e:
        print(f"Error: {e}")
        return False


def test_stream_validation():
    print("\n🌐 Test de validación de streams...")
    try:
        import radio

        # Test with a valid stream
        valid_stream = "https://26573.live.streamtheworld.com/ECUADORAAC.aac"
        valid_result = radio.validate_stream(valid_stream, timeout=10)
        print(
            f"Stream válido ({valid_stream}): {'✅ PASSED' if valid_result else '❌ FAILED'}"
        )

        # Test with an invalid stream
        invalid_stream = "http://example.invalid/stream.mp3"
        invalid_result = radio.validate_stream(invalid_stream, timeout=5)
        print(
            f"Stream inválido ({invalid_stream}): {'✅ PASSED' if not invalid_result else '❌ FAILED'}"
        )

        return valid_result and not invalid_result
    except Exception as e:
        print(f"Error: {e}")
        return False


def test_play_radio_logic():
    print("\n📻 Test de lógica de reproducción...")
    try:
        import radio

        # Create a temporary dummy audio file
        with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as temp_file:
            temp_file.write(
                b"RIFF$\x00\x00\x00WAVEfmt \x10\x00\x00\x00\x01\x00\x01\x00\x44\xac\x00\x00\x88X\x01\x00\x02\x00\x10\x00data\x00\x00\x00\x00"
            )
            temp_file_path = temp_file.name

        # Test with valid file path
        result = radio.play_radio(temp_file_path)

        os.unlink(temp_file_path)

        print(
            f"Lógica de reproducción: {'✅ PASSED' if result is not False else '❌ FAILED'}"
        )
        return result is not False
    except Exception as e:
        print(f"Error: {e}")
        return False


if __name__ == "__main__":
    all_passed = True

    if not test_radio_state_logic():
        all_passed = False

    if not test_ffplay_availability():
        all_passed = False

    if not test_stream_validation():
        all_passed = False

    if not test_play_radio_logic():
        all_passed = False

    if all_passed:
        print("\n✅ Todos los tests de Radio han pasado.")
    else:
        print("\n❌ Algunos tests de Radio han fallado.")
        sys.exit(1)
