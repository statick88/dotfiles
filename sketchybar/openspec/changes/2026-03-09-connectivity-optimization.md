# Delta Spec: Connectivity Plugin Optimization (v3.5.0)

**Status**: PROPOSED
**Target**: `plugins/connectivity.py`

## Requirements
1. **WiFi Logic**:
   - MUST show SSID and signal strength (dBm to bars mapping).
   - MUST show `󰤮` (Red) if disconnected.
2. **Bluetooth Logic**:
   - MUST detect if Bluetooth is ON/OFF.
   - MUST show name of connected device if available (limited to 10 chars).
3. **UX/UI Interaction**:
   - Left-click (WiFi): Open Network Preferences.
   - Left-click (Bluetooth): Open Bluetooth Preferences.
4. **Resilience**:
   - MUST use non-blocking commands for `networksetup` and `blueutil` (if available).
   - Graceful degradation if tools are missing.

## Validation & Testing Plan
- **Test Script**: `tests/test_connectivity.py`.
- **Scenario A**: Mock disconnected states for both WiFi and BT.
- **Scenario B**: Mock long SSIDs and ensure label clipping/formatting.
- **Scenario C**: Verify mapping of signal dBm to WiFi icons.
