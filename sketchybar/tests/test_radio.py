#!/usr/bin/env python3
import os
import sys
import json
import subprocess
from unittest.mock import MagicMock, patch

# Setup paths
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

# Mock utils before importing audio
import utils
utils.COLORS = {
    "BLACK": "0xff06080f", "WHITE": "0xfff3f6f9", "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85", "YELLOW": "0xffffe066", "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca", "MAGENTA": "0xffff8dd7", "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000", "ISLAND_BG": "0xff121620", "ISLAND_BORDER": "0xff263356",
    "ACCENT": "0xffe0c15a", "DIM": "0xff565f89",
}
utils.sbar_set = MagicMock()
utils.get_state = MagicMock(return_value={"current_id": "exa"})
utils.save_state = MagicMock()
utils.notify = MagicMock()

import audio

def test_station_list():
    print("\n[1] Testing Station List and Order...")
    expected_order = ["exa", "boqueron", "airelatino", "caravana"]
    if audio.STATION_ORDER == expected_order:
        print(f"  ✅ Order correct: {audio.STATION_ORDER}")
    else:
        print(f"  ❌ Order INCORRECT: {audio.STATION_ORDER}")
        sys.exit(1)

def test_play_logic():
    print("\n[2] Testing Play Logic...")
    with patch('subprocess.Popen') as mock_popen, \
         patch('subprocess.run') as mock_run:
        audio.play_radio("exa")
        assert mock_popen.called, "ffplay should be started"
        print("  ✅ Play Logic: OK")

if __name__ == "__main__":
    try:
        test_station_list()
        test_play_logic()
        print("\n🚀 TESTS DE RADIO (AUDIO) PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR: {e}")
        sys.exit(1)
