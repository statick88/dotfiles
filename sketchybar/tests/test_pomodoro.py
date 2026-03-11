#!/usr/bin/env python3
import sys
import os
import time

sys.path.append(os.path.join(os.getcwd(), "plugins"))

from pomodoro import get_next_session


def test_get_next_session():
    print("🚀 Iniciando Test de Lógica de Pomodoro...")

    # Test work → short break
    state = {"session_type": "work", "work_sessions_completed": 0}
    result = get_next_session(state.copy())
    print(
        f"Test Work → Short Break: {'PASSED' if result['session_type'] == 'short_break' and result['work_sessions_completed'] == 1 else 'FAILED'}"
    )

    # Test work → long break (after 4 sessions)
    state = {"session_type": "work", "work_sessions_completed": 3}
    result = get_next_session(state.copy())
    print(
        f"Test Work → Long Break: {'PASSED' if result['session_type'] == 'long_break' and result['work_sessions_completed'] == 0 else 'FAILED'}"
    )

    # Test short break → work
    state = {"session_type": "short_break", "work_sessions_completed": 1}
    result = get_next_session(state.copy())
    print(
        f"Test Short Break → Work: {'PASSED' if result['session_type'] == 'work' else 'FAILED'}"
    )

    # Test long break → work
    state = {"session_type": "long_break", "work_sessions_completed": 0}
    result = get_next_session(state.copy())
    print(
        f"Test Long Break → Work: {'PASSED' if result['session_type'] == 'work' else 'FAILED'}"
    )


if __name__ == "__main__":
    test_get_next_session()
