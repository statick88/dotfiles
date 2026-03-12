#!/usr/bin/env python3
import sys
import os
import time
from unittest.mock import patch, MagicMock

sys.path.append(os.path.join(os.getcwd(), "plugins"))

# Mock utils before import
import utils
utils.notify = MagicMock()
utils.play_sound = MagicMock()
utils.get_state = MagicMock(return_value={"mode": "normal"})

from pomodoro import get_next_session

def test_get_next_session():
    print("🚀 Iniciando Test de Lógica de Pomodoro...")
    errors = 0

    # Test work → short break
    state = {"session_type": "work", "completed_work": 0, "total_pomodoros": 0}
    result = get_next_session(state.copy())
    if result['session_type'] == 'short_break' and result['completed_work'] == 1:
        print("  ✅ Test Work → Short Break: PASSED")
    else:
        print(f"  ❌ Test Work → Short Break: FAILED (Got {result['session_type']}, {result['completed_work']})")
        errors += 1

    # Test work → long break (after 4 sessions)
    state = {"session_type": "work", "completed_work": 3, "total_pomodoros": 3}
    result = get_next_session(state.copy())
    if result['session_type'] == 'long_break' and result['completed_work'] == 0:
        print("  ✅ Test Work → Long Break: PASSED")
    else:
        print(f"  ❌ Test Work → Long Break: FAILED (Got {result['session_type']}, {result['completed_work']})")
        errors += 1

    # Test short break → work
    state = {"session_type": "short_break", "completed_work": 1, "total_pomodoros": 1}
    result = get_next_session(state.copy())
    if result['session_type'] == 'work':
        print("  ✅ Test Short Break → Work: PASSED")
    else:
        print(f"  ❌ Test Short Break → Work: FAILED")
        errors += 1

    if errors > 0:
        sys.exit(1)

if __name__ == "__main__":
    test_get_next_session()
