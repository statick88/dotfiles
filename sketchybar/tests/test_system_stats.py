#!/usr/bin/env python3
import os
import sys
import subprocess
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

import system_stats

def test_cpu_logic():
    print("\n[1] Testing CPU Logic Parsing...")
    # Simulated top output
    mock_top = "CPU usage: 10.50% user, 5.50% sys, 84.00% idle"
    with patch('subprocess.run') as mock_run:
        mock_run.return_value = MagicMock(stdout=mock_top)
        val_str, val_int, detail = system_stats.get_cpu_info()
        assert "16%" in val_str, f"Expected ~16%, got {val_str}"
        assert val_int == 16, f"Expected 16, got {val_int}"
        print("  ✅ CPU Logic: OK")

def test_ram_logic():
    print("\n[2] Testing RAM Logic Parsing...")
    # Simulated top output for PhysMem (fallback path)
    mock_top = "PhysMem: 10G used (2000M wired, 1000M compressor), 6G unused."
    with patch('subprocess.run') as mock_run, \
         patch('subprocess.check_output', side_effect=Exception("Mocking vm_stat fail")):
        mock_run.return_value = MagicMock(stdout=mock_top)
        val_str, val_int, detail = system_stats.get_ram_info()
        assert "62%" in val_str, f"Expected ~62%, got {val_str}"
        assert val_int == 62
        print("  ✅ RAM Logic: OK")

def test_dynamic_popup_updates():
    print("\n[3] Testing Dynamic Popup Updates (Sync)...")
    # Verify that calling main for 'cpu' also updates the popup items
    with patch.dict(os.environ, {"NAME": "cpu", "SENDER": ""}), \
         patch('system_stats.get_cpu_info', return_value=("10%", 10, "Detail")):
        system_stats.main()
        calls = [call.args[0] for call in utils.sbar_set.call_args_list]
        assert "cpu.info.used" in calls, "cpu.info.used should be updated"
        print("  ✅ Dynamic Updates: OK")

if __name__ == "__main__":
    try:
        test_cpu_logic()
        test_ram_logic()
        test_dynamic_popup_updates()
        print("\n🚀 TESTS DE SYSTEM-STATS PASADOS.")
    except AssertionError as e:
        print(f"\n❌ ERROR EN LOS TESTS: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ ERROR INESPERADO: {e}")
        sys.exit(1)
