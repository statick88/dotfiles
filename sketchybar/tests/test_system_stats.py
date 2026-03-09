#!/usr/bin/env python3
import os
import sys
import importlib.util
from unittest.mock import MagicMock, patch

# Add plugins path for import
sys.path.append(os.path.join(os.getcwd(), "plugins"))

# Mock utils module
import utils

utils.COLORS = {"YELLOW": "yellow", "CYAN": "cyan", "GREEN": "green", "WHITE": "white"}
utils.sbar_set = MagicMock()

# Import the system stats module using importlib since it has a hyphen
plugin_path = os.path.join(os.getcwd(), "plugins", "system-stats.py")
spec = importlib.util.spec_from_file_location("system_stats", plugin_path)
system_stats = importlib.util.module_from_spec(spec)
spec.loader.exec_module(system_stats)


def run_tests():
    print("🚀 Starting System Stats Plugin Tests...")
    errors = 0

    # --- Test 1: CPU Usage ---
    print("\n[1] Test CPU Usage:")

    # Test successful case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.return_value = MagicMock(
            stdout="CPU usage: 15.2% user, 8.3% sys, 76.5% idle", stderr=""
        )
        val, icon, color = system_stats.get_cpu_usage()
        if val == "15%" and icon == "󰍛" and color == "yellow":
            print("  ✅ CPU usage parsing: OK")
        else:
            print(f"  ❌ CPU usage parsing: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # Test error case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.side_effect = Exception("Test error")
        val, icon, color = system_stats.get_cpu_usage()
        if val == "0%" and icon == "󰍛" and color == "yellow":
            print("  ✅ CPU error handling: OK")
        else:
            print(f"  ❌ CPU error handling: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # --- Test 2: RAM Usage ---
    print("\n[2] Test RAM Usage:")

    # Test successful case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.return_value = MagicMock(
            stdout="System-wide memory free percentage: 75%", stderr=""
        )
        val, icon, color = system_stats.get_ram_usage()
        if val == "25%" and icon == "󰘚" and color == "cyan":
            print("  ✅ RAM usage parsing: OK")
        else:
            print(f"  ❌ RAM usage parsing: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # Test error case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.side_effect = Exception("Test error")
        val, icon, color = system_stats.get_ram_usage()
        if val == "0%" and icon == "󰘚" and color == "cyan":
            print("  ✅ RAM error handling: OK")
        else:
            print(f"  ❌ RAM error handling: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # --- Test 3: GPU Usage ---
    print("\n[3] Test GPU Usage:")

    # Test Apple Silicon GPU case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.return_value = MagicMock(stdout="GPU Activity: 45%", stderr="")
        val, icon, color = system_stats.get_gpu_usage()
        if val == "45%" and icon == "󰢮" and color == "green":
            print("  ✅ GPU usage parsing: OK")
        else:
            print(f"  ❌ GPU usage parsing: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # Test Intel GPU fallback case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:

        def side_effect(cmd, **kwargs):
            if cmd[0] == "powermetrics":
                raise Exception("powermetrics not supported")
            return MagicMock(stdout="Metal: Supported", stderr="")

        mock_run.side_effect = side_effect
        val, icon, color = system_stats.get_gpu_usage()
        if val == "0%" and icon == "󰢮" and color == "green":
            print("  ✅ Intel GPU fallback: OK")
        else:
            print(f"  ❌ Intel GPU fallback: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    # Test GPU error case
    with patch("builtins.print"), patch("subprocess.run") as mock_run:
        mock_run.side_effect = Exception("Test error")
        val, icon, color = system_stats.get_gpu_usage()
        if val == "0%" and icon == "󰢮" and color == "green":
            print("  ✅ GPU error handling: OK")
        else:
            print(f"  ❌ GPU error handling: FAILED (Got {val}, {icon}, {color})")
            errors += 1

    print(
        f"\n--- Final Result: {'PASSED' if errors == 0 else 'FAILED'} ({errors} errors) ---"
    )
    return errors


if __name__ == "__main__":
    sys.exit(run_tests())
