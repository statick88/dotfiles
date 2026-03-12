#!/usr/bin/env python3
import os
import sys
import subprocess
from unittest.mock import MagicMock, patch

sys.path.append(os.path.join(os.getcwd(), 'plugins'))

import utils
utils.COLORS = {
    "BLACK": "0xff06080f", "WHITE": "0xfff3f6f9", "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85", "YELLOW": "0xffffe066", "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca", "MAGENTA": "0xffff8dd7", "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000", "ISLAND_BG": "0xff121620", "ISLAND_BORDER": "0xff263356",
    "ACCENT": "0xffe0c15a", "DIM": "0xff565f89",
}
utils.sbar_set = MagicMock()
utils.get_state = MagicMock(return_value={"last_ib": 0, "last_ob": 0, "last_t": 1000.0})
utils.save_state = MagicMock()

import connectivity

def test_popup_items_sync():
    print("\n[1] Testing Popup Items Sync with sketchybarrc...")
    with patch('connectivity.get_wifi_info', return_value={"ip": "1.1.1.1", "ssid": "MiRed", "mask": "255.255.255.0", "router": "1.1.1.254"}), \
         patch.dict(os.environ, {"NAME": "wifi", "SENDER": "mouse.entered"}):
        connectivity.main()
        
        # Check for EXACT item names from sketchybarrc
        calls = [call.args[0] for call in utils.sbar_set.call_args_list]
        assert "wifi.info.ip" in calls, "wifi.info.ip missing"
        assert "wifi.info.mask" in calls, "wifi.info.mask missing"
        assert "wifi.info.router" in calls, "wifi.info.router missing"
        assert "wifi.info.speed" in calls, "wifi.info.speed missing"
        print("  ✅ Popup Items: Synchronized")

def test_connection_by_ip_priority():
    print("\n[2] Testing Connection Status (IP Priority)...")
    # Simulate IP present but SSID check failing
    with patch('subprocess.run') as mock_run:
        # Mocking for get_wifi_info("en0") specifically:
        # 1. ipconfig getifaddr en0
        # 2. networksetup -getairportnetwork en0
        # 3. ifconfig en0
        # 4. netstat -rn
        mock_run.side_effect = [
            MagicMock(stdout="192.168.0.106"),       # ipconfig IP
            MagicMock(stdout="You are not associated with an AirPort network."), # networksetup SSID
            MagicMock(stdout="netmask 0xffffff00"),  # ifconfig mask
            MagicMock(stdout="default 192.168.0.1 en0") # netstat router
        ]
        
        info = connectivity.get_wifi_info("en0")
        assert info["ip"] == "192.168.0.106", f"IP detection failed, got {info['ip']}"
        assert info["ssid"] == "Conectado", f"SSID should be 'Conectado' when SSID is hidden but IP exists, got '{info['ssid']}'"
        print("  ✅ Connection Status: Robust")

if __name__ == "__main__":
    try:
        test_popup_items_sync()
        test_connection_by_ip_priority()
        print("\n🚀 TESTS DE CONECTIVIDAD PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ ERROR INESPERADO: {e}")
        sys.exit(1)
