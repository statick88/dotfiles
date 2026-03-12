#!/usr/bin/env python3
import os
import sys
import subprocess
from unittest.mock import MagicMock, patch

# Setup paths to import from plugins
sys.path.append(os.path.join(os.getcwd(), 'plugins'))

# Mock utils before importing battery
import utils
utils.COLORS = {
    "BLACK": "0xff06080f",
    "WHITE": "0xfff3f6f9",
    "RED": "0xffcb7c94",
    "GREEN": "0xffb7cc85",
    "YELLOW": "0xffffe066",
    "ORANGE": "0xfffff7b1",
    "BLUE": "0xff7fb4ca",
    "MAGENTA": "0xffff8dd7",
    "CYAN": "0xff7aa89f",
    "TRANSPARENT": "0x00000000",
    "ISLAND_BG": "0xff121620",
    "ISLAND_BORDER": "0xff263356",
    "ACCENT": "0xffe0c15a",
    "DIM": "0xff565f89",
}
utils.sbar_set = MagicMock()
utils.notify = MagicMock()
utils.get_state = MagicMock(return_value={"last_alert": None})
utils.save_state = MagicMock()

import battery

def test_battery_info_parsing():
    print("\n[1] Testing Battery Info Parsing (pmset + ioreg)...")
    
    # Mock pmset output
    pmset_out = "Now drawing from 'Battery Power'\n -InternalBattery-0 (id=12345) 85%; discharging; 2:30 remaining; present: true"
    
    # Mock ioreg output (simplified)
    ioreg_out = '"CycleCount" = 150\n"MaxCapacity" = 4500\n"CurrentCapacity" = 3825'
    
    with patch('subprocess.run') as mock_run:
        mock_run.side_effect = [
            MagicMock(stdout=pmset_out),
            MagicMock(stdout=ioreg_out)
        ]
        
        perc, char, time, cond, cycles = battery.get_battery_info()
        
        assert perc == 85, f"Expected 85%, got {perc}%"
        assert char is False, "Expected discharging"
        assert time == "2:30", f"Expected 2:30, got {time}"
        assert cycles == 150, f"Expected 150 cycles, got {cycles}"
        print("  ✅ Info Parsing: OK")

def test_battery_ui_logic():
    print("\n[2] Testing Battery UI Logic...")
    
    icon, color = battery.get_battery_ui(15, False)
    assert icon == "󰁺" and color == utils.COLORS["RED"], "Low battery UI failed"
    
    icon, color = battery.get_battery_ui(100, True)
    assert icon == "󱐋" and color == utils.COLORS["YELLOW"], "Charging UI failed"
    print("  ✅ UI Logic: OK")

def test_hover_events():
    print("\n[3] Testing Hover Events (Mouse Entered/Exited)...")
    
    with patch.dict(os.environ, {"NAME": "battery", "SENDER": "mouse.entered"}):
        with patch('battery.get_battery_info', return_value=(85, False, "2:30", "Normal", 150)):
            battery.main()
            # Verify popup items were set
            calls = [call.args[0] for call in utils.sbar_set.call_args_list]
            assert "battery.time" in calls or any("label=Restante: 2:30" in str(c) for c in utils.sbar_set.call_args_list)
            print("  ✅ Mouse Entered: OK")

    utils.sbar_set.reset_mock()
    with patch.dict(os.environ, {"NAME": "battery", "SENDER": "mouse.exited"}):
        battery.main()
        # Verify that popup.drawing=off was called in the properties dictionary
        found = False
        for call in utils.sbar_set.call_args_list:
            name_arg, props_arg = call.args
            if name_arg == "battery" and props_arg.get("popup.drawing") == "off":
                found = True
                break
        assert found, "popup.drawing=off not found in sbar_set calls on mouse.exited"
        print("  ✅ Mouse Exited: OK")

def test_click_event():
    print("\n[4] Testing Click Event (System Settings)...")
    
    with patch.dict(os.environ, {"NAME": "battery", "SENDER": "mouse.clicked"}):
        with patch('subprocess.run') as mock_run:
            battery.main()
            # Check if open command was called
            args = [call.args[0] for call in mock_run.call_args_list]
            opened_settings = any("x-apple.systempreferences:com.apple.Battery-Settings.extension" in str(arg) for arg in args)
            assert opened_settings, "System settings not opened on click"
            print("  ✅ Mouse Clicked: OK")

def test_power_source_notifications():
    print("\n[5] Testing Power Source Notifications...")
    
    # Reset mocks
    utils.notify.reset_mock()
    
    # 1. Test Connecting Charger
    state = {"last_alert": "safe", "last_charging": False}
    battery.get_health_alert(85, True, state)
    utils.notify.assert_any_call("⚡ Cargador Conectado", "Su Mac ahora tiene energía constante, vea usted.")
    print("  ✅ Connect Charger Notification: OK")
    
    # 2. Test Disconnecting Charger
    utils.notify.reset_mock()
    state = {"last_alert": "safe", "last_charging": True}
    battery.get_health_alert(85, False, state)
    utils.notify.assert_any_call("🔋 Usando Batería", "Ya le quitó el cable, ¡qué pues!")
    print("  ✅ Disconnect Charger Notification: OK")

if __name__ == "__main__":
    try:
        test_battery_info_parsing()
        test_battery_ui_logic()
        test_hover_events()
        test_click_event()
        test_power_source_notifications()
        print("\n🚀 TODITITOS LOS TESTS PASARON, ¡QUÉ PUES!")
    except AssertionError as e:
        print(f"\n❌ ERROR EN LOS TESTS: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ ERROR INESPERADO: {e}")
        sys.exit(1)
