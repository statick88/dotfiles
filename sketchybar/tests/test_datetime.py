#!/usr/bin/env python3
import os
import sys
import time
from datetime import datetime
from unittest.mock import MagicMock, patch

# Setup paths
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

# Mock utils
import utils
utils.COLORS = {
    "BLACK": "0xff06080f", "WHITE": "0xfff3f6f9", "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85", "YELLOW": "0xffffe066", "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca", "MAGENTA": "0xffff8dd7", "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000", "ISLAND_BG": "0xff121620", "ISLAND_BORDER": "0xff263356",
}
utils.sbar_set = MagicMock()
utils.get_state = MagicMock(return_value={"last_fetch": 0, "events": []})
utils.save_state = MagicMock()

import datetime_plugin

def test_timezone_gmt5():
    print("\n[1] Testing GMT-5 Timezone Enforcement...")
    # TZ should be America/Guayaquil
    assert os.environ.get("TZ") == "America/Guayaquil", "Timezone not set to Ecuador"
    print("  ✅ Timezone: America/Guayaquil (GMT-5)")

def test_date_format():
    print("\n[2] Testing Date Format...")
    now = datetime.now()
    expected = now.strftime("%a %d %b %H:%M")
    
    with patch.dict(os.environ, {"NAME": "datetime", "SENDER": ""}):
        datetime_plugin.main()
        calls = [call.args[1] for call in utils.sbar_set.call_args_list if call.args[0] == "datetime"]
        label = str(calls[-1].get("label"))
        assert label == expected, f"Expected '{expected}', got '{label}'"
        print("  ✅ Date Format: OK")

def test_async_fetch_lock():
    print("\n[3] Testing Async Fetch Lock...")
    lock_path = "/tmp/sketchybar_gcal_fetch.lock"
    
    # Simulate an active fetch by creating a lock
    with open(lock_path, "w") as f:
        f.write("test")
    
    with patch('subprocess.Popen') as mock_popen:
        datetime_plugin.update_google_data_async()
        assert not mock_popen.called, "Async fetch should NOT start if lock exists"
        print("  ✅ Async Fetch Lock: OK")
    
    # Cleanup
    if os.path.exists(lock_path):
        os.remove(lock_path)

if __name__ == "__main__":
    try:
        test_timezone_gmt5()
        test_date_format()
        test_async_fetch_lock()
        print("\n🚀 TESTS DE DATETIME PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR EN LOS TESTS: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ ERROR INESPERADO: {e}")
        sys.exit(1)
