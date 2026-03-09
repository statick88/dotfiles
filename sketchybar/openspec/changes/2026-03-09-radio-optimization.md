# Delta Spec: Radio Plugin Optimization (v3.3.0)

**Status**: PROPOSED
**Target**: `plugins/radio.py`, `state/radio.json`

## Requirements
1. **New Station**: MUST add "Aire Latino 88.5 España" to the `STATIONS` dictionary.
   - Stream URL: [To be researched or provided].
2. **Reliability**:
   - Stream validation: Ensure `ffplay` doesn't hang on connection drops.
   - Stop logic: Ensure all instances of `ffplay` are terminated before starting a new one.
3. **UX Improvements**:
   - Auto-pause Spotify: Re-confirm functionality.
   - Popup behavior: Keep the 5-second auto-close and the mouse-exited close logic.

## Validation & Testing Plan
- **Test Script**: `tests/test_radio.py`.
- **Scenario A**: Verify station switching terminantes previous process.
- **Scenario B**: Verify state persistence (saving the current station in JSON).
- **Scenario C**: Verify Spotify pausing (mocking osascript).
