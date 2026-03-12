#!/usr/bin/env python3
import os
import sys
import subprocess
from unittest.mock import MagicMock, patch

# Setup paths to import from plugins
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

# Mock utils before importing volume
import utils
utils.COLORS = {
    "BLACK": "0xff06080f", "WHITE": "0xfff3f6f9", "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85", "YELLOW": "0xffffe066", "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca", "MAGENTA": "0xffff8dd7", "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000", "ISLAND_BG": "0xff121620", "ISLAND_BORDER": "0xff263356",
    "ACCENT": "0xffe0c15a", "DIM": "0xff565f89",
}
utils.sbar_set = MagicMock()
utils.get_state = MagicMock(return_value={"mode": "normal"})

import volume

def test_volume_parsing():
    print("\n[1] Testing Volume Parsing (osascript)...")
    mock_out = "output volume:50, input volume:50, alert volume:50, output muted:false"
    with patch('subprocess.run') as mock_run:
        mock_run.return_value = MagicMock(stdout=mock_out)
        vol, muted = volume.get_volume_settings()
        assert vol == 50, f"Expected 50, got {vol}"
        assert muted is False, "Should not be muted"
        print("  ✅ Volume Parsing: OK")

def test_bar_generation():
    print("\n[2] Testing Visual Bar Generation...")
    bar = volume.make_bar(50, size=10)
    assert bar == "█████░░░░░", f"Expected '█████░░░░░', got '{bar}'"
    print("  ✅ Bar Generation: OK")

def test_scroll_logic():
    print("\n[3] Testing Scroll Events (Up/Down)...")
    
    # Test Scroll Up
    with patch.dict(os.environ, {"NAME": "volume", "SENDER": "mouse.scrolled.up"}):
        with patch('volume.get_volume_settings', return_value=(50, False)), \
             patch('subprocess.run') as mock_run:
            volume.main()
            # Verify osascript was called to set volume to 55
            args = [call.args[0] for call in mock_run.call_args_list]
            set_vol_call = any("set volume output volume 55" in str(arg) for arg in args)
            assert set_vol_call, "Volume was not increased by 5 on scroll up"
            print("  ✅ Scroll Up (+5%): OK")

    # Test Scroll Down
    with patch.dict(os.environ, {"NAME": "volume", "SENDER": "mouse.scrolled.down"}):
        with patch('volume.get_volume_settings', return_value=(50, False)), \
             patch('subprocess.run') as mock_run:
            volume.main()
            # Verify osascript was called to set volume to 45
            args = [call.args[0] for call in mock_run.call_args_list]
            set_vol_call = any("set volume output volume 45" in str(arg) for arg in args)
            assert set_vol_call, "Volume was not decreased by 5 on scroll down"
            print("  ✅ Scroll Down (-5%): OK")

if __name__ == "__main__":
    try:
        test_volume_parsing()
        test_bar_generation()
        test_scroll_logic()
        print("\n🚀 TESTS DE VOLUMEN (PARTE 1) PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR EN LOS TESTS: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ ERROR INESPERADO: {e}")
        sys.exit(1)
