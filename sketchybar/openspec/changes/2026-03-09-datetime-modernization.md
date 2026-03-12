# Delta Spec: Datetime Plugin Modernization (v3.1.1)

**Status**: PROPOSED
**Target**: `plugins/calendar.py`, `sketchybarrc`

## Requirements
1. **Engine**: MUST use `calendar.py` (Python 3).
2. **Visuals**: MUST show date and time in format `%a %d %b %H:%M` (e.g., "Mon 09 Mar 14:30").
3. **Interactivity**: 
   - Left-click MUST open Google Calendar in the default browser (using `open` command).
4. **Cleanup**: MUST remove `plugins/datetime.sh` after successful integration.
5. **Stability**: NO changes to other plugins or global bar styles.

## Proposed Changes
- Update `calendar.py` to ensure it targets the `datetime` item name correctly.
- Update `sketchybarrc` to point exclusively to `calendar.py`.
- Remove `plugins/datetime.sh`.
