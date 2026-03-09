# Delta Spec: Volume Plugin Modernization (v3.4.0)

**Status**: PROPOSED
**Target**: `plugins/volume.py`

## Requirements
1. **Dynamic Visuals**:
   - Icon MUST change based on volume range:
     - 0% or Muted: `󰝟` (Red)
     - 1-33%: `󰕿` (Cyan)
     - 34-66%: `󰖀` (Cyan)
     - 67-100%: `󰕾` (Cyan)
2. **Interaction (Master Pause)**:
   - Left-click MUST toggle Mute state.
   - WHEN Muted: MUST pause Spotify (osascript) and stop Radio (ffplay).
   - Right-click: MUST open Sound Preferences.
3. **UX/UI Optimization**:
   - MUST reduce right padding of the Volume item to 0 to compact the connection with Bluetooth.
4. **Robustness**:
   - Error handling for missing `osascript` output or audio device disconnects.

## Validation & Testing Plan
- **Test Script**: `tests/test_volume.py`.
- **Scenario A**: Verify correct icon for 0, 50, and 100%.
- **Scenario B**: Verify Mute detection logic.
- **Scenario C**: Simulate `osascript` failure and ensure graceful degradation (0%).
