# Delta Spec: Connectivity Interactive Menu (v3.5.1)

**Status**: PROPOSED
**Target**: `plugins/connectivity.py`, `sketchybarrc`

## Requirements
1. **Real-time Status**:
   - MUST accurately detect ON/OFF/Disconnected states.
   - WiFi Icon: `󰤮` (Off/Disc), `󰤨` (Connected).
   - BT Icon: `󰂲` (Off), `󰂯` (On), `󰂱` (Connected).
2. **Interactive Popup (Minimalist)**:
   - Left-click MUST toggle a popup menu.
   - Popup MUST list:
     - WiFi: Top 5 available networks + Saved networks.
     - BT: Paired/Known devices.
3. **Smart Connection**:
   - Clicking a network/device in the popup MUST attempt to connect.
   - For WiFi: Use `networksetup -setairportnetwork`.
   - For BT: Use `blueutil --connect` (if available) or notify user.
4. **Resilience**:
   - Scan only on click to prevent bar lag.
   - Graceful fallback if scanning fails.

## Validation Plan
- **Test Script**: `tests/test_connectivity_interactive.py`.
- **Scenario**: Verify popup population logic without breaking the main bar.
