# Delta Spec: Connectivity Plugin Rewrite (v4.1.0)

**Status**: IMPLEMENTED ✅
**Target**: `plugins/connectivity.py`, `tests/test_connectivity.py`, `sketchybarrc`
**Date**: 2026-03-09

## Summary

Complete rewrite of connectivity plugin with battery-pattern popup behavior:
hover shows network details, click shows interactive menu, popups stay open correctly.

## Changes Made

### `plugins/connectivity.py` — Full Rewrite (v4.1.0)

**Architecture**: Class-based with `WiFiManager`, `BluetoothManager`, battery-pattern dispatcher.

**Popup behavior (battery pattern)**:
- `mouse.entered` → fill popup with details + `popup.drawing=on` + **return**
- `mouse.exited` / `mouse.exited.global` → `popup.drawing=off` + **return**
- `mouse.clicked` → show interactive network/device menu + **return**
- `routine` → update icon only, **never touch popup**

**WiFi hover details**: SSID (signal%), IP, Subnet Mask, Gateway, Traffic ↓/↑
**WiFi click menu**: Toggle power + preferred networks list → click opens System Preferences
**Bluetooth hover**: Power status + connected devices
**Bluetooth click**: Toggle power + paired devices with connect/disconnect

**Key methods added**:
- `WiFiManager.get_network_details(interface)`: IP, mask (hex→dotted), gateway
- `WiFiManager.get_traffic_bytes(interface)`: Raw bytes from netstat
- `_show_wifi_details(name)` / `_show_bt_details(name)`: Hover popup fillers
- `_format_speed(bps)`: Human-readable KB/s or MB/s

### `sketchybarrc` — Popup Items Restructured
- `update_freq`: 1 → **5** for both wifi and bluetooth
- Added `mouse.exited.global` subscription (prevents stuck popups)
- Added `wifi.ssid`, `wifi.mask` popup items
- Renamed `bluetooth.details` → `bluetooth.status` + `bluetooth.devices`
- Speedtest button → "Network Settings" (opens System Preferences WiFi)

### `tests/test_connectivity.py` — Bug Fix
- Fixed `"--add" in call.args` → `"--add" in call.args[0]`

## Validation
- **36/36 tests passing** ✅
- **0 regressions** in other suites
- **bash -n sketchybarrc** ✅
- **py_compile connectivity.py** ✅
