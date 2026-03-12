# Delta Spec: Pomodoro Plugin Improvements (v3.3.0)

**Status**: PROPOSED
**Target**: `plugins/pomodoro.py`, `tests/test_pomodoro.py`

## Requirements

1. **Fix Direct Subprocess Call**: MUST replace the direct `subprocess.run(["sketchybar"])` call with the `sbar_set` utility function for consistency with other plugins.

2. **Error Handling**:
   - MUST add error handling for the `notify()` function to prevent failures from affecting main functionality
   - MUST add error handling for the `play_sound()` function to prevent failures from affecting main functionality
   - Errors should be logged or handled gracefully without crashing the plugin

3. **Test File Creation**: MUST create `tests/test_pomodoro.py` to test the pomodoro functionality
   - Test core state management (active/inactive, time tracking)
   - Test session transitions (work → short break → long break)
   - Test utility functions like `get_next_session()`
   - Mock external dependencies (notify, play_sound, save_state, get_state)

4. **Code Quality**: MUST maintain consistency with existing plugin patterns
   - Follow the coding style of other plugins (radio.py, volume.py, etc.)
   - Use existing utility functions from utils.py
   - Maintain compatibility with Python 3.9+

## Validation & Testing Plan

- **Test Script**: `tests/test_pomodoro.py`.
- **Scenario A**: Test initial state loading and default values
- **Scenario B**: Test session toggling (start/stop pomodoro)
- **Scenario C**: Test time countdown functionality
- **Scenario D**: Test session transitions (work → short break, short break → work, etc.)
- **Scenario E**: Test notification and sound error handling
- **Scenario F**: Test state persistence (saving/loading from state file)
- **Scenario G**: Verify that sbar_set is used instead of direct subprocess call
