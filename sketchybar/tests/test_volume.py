#!/usr/bin/env python3
import sys
import os

def get_volume_icon(vol, muted):
    """Replicated logic from volume.py"""
    if muted or vol == 0:
        return "󰝟", "RED"
    elif vol < 33:
        return "󰕿", "CYAN"
    elif vol < 66:
        return "󰖀", "CYAN"
    else:
        return "󰕾", "CYAN"

def run_tests():
    print("🚀 Iniciando Test de Lógica de Volumen...")
    
    # Test Muted
    icon, color = get_volume_icon(50, True)
    print(f"Test Muted (50%): {'PASSED' if icon == '󰝟' and color == 'RED' else 'FAILED'}")

    # Test 20%
    icon, color = get_volume_icon(20, False)
    print(f"Test Low (20%): {'PASSED' if icon == '󰕿' and color == 'CYAN' else 'FAILED'}")

    # Test 50%
    icon, color = get_volume_icon(50, False)
    print(f"Test Mid (50%): {'PASSED' if icon == '󰖀' and color == 'CYAN' else 'FAILED'}")

    # Test 100%
    icon, color = get_volume_icon(100, False)
    print(f"Test High (100%): {'PASSED' if icon == '󰕾' and color == 'CYAN' else 'FAILED'}")

if __name__ == "__main__":
    run_tests()
