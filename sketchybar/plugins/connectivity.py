#!/usr/bin/env python3
"""
Consolidated connectivity plugin: WiFi + Bluetooth
Updates both items in a single call to reduce subprocess overhead.
Handles errors gracefully — if one fails, the other still updates.
"""

import os
import shutil
import subprocess

# Bluetooth icons
BT_ICON_CONNECTED = "󰂱"
BT_ICON_ON = "󰂯"
BT_ICON_OFF = "󰂲"

# WiFi icons
WIFI_INTERFACE = "en0"
WIFI_ICON_OFF = "󰤭"
WIFI_ICON_DISCONNECTED = "󰤯"
WIFI_ICON_CONNECTED = "󰤨"


def get_bluetooth_power() -> bool:
    """Check if Bluetooth is powered on."""
    try:
        result = subprocess.run(
            ["blueutil", "-p"], capture_output=True, text=True, timeout=5
        )
        return result.stdout.strip() == "1"
    except Exception:
        return False


def get_connected_bt_count() -> int:
    """Get count of connected Bluetooth devices."""
    try:
        result = subprocess.run(
            ["blueutil", "--connected"], capture_output=True, text=True, timeout=5
        )
        if not result.stdout.strip():
            return 0
        return result.stdout.count("address")
    except Exception:
        return 0


def get_bluetooth_status():
    """
    Return (icon, label) for Bluetooth.
    Handles missing blueutil gracefully.
    """
    if not shutil.which("blueutil"):
        return BT_ICON_OFF, "N/A"

    if not get_bluetooth_power():
        return BT_ICON_OFF, ""

    count = get_connected_bt_count()
    if count > 0:
        return BT_ICON_CONNECTED, str(count)
    else:
        return BT_ICON_ON, ""


def get_wifi_power() -> bool:
    """Check if WiFi is powered on."""
    try:
        result = subprocess.run(
            ["networksetup", "-getairportpower", WIFI_INTERFACE],
            capture_output=True,
            text=True,
            timeout=5,
        )
        return "On" in result.stdout
    except Exception:
        return False


def get_ssid() -> "str | None":
    """Get connected WiFi SSID."""
    try:
        result = subprocess.run(
            ["ipconfig", "getsummary", WIFI_INTERFACE],
            capture_output=True,
            text=True,
            timeout=5,
        )
        for line in result.stdout.splitlines():
            if "SSID" in line and "BSSID" not in line:
                parts = line.split(" : ")
                if len(parts) >= 2:
                    return parts[1].strip()
    except Exception:
        pass
    return None


def get_wifi_status():
    """
    Return icon for WiFi.
    Handles errors gracefully.
    """
    try:
        if not get_wifi_power():
            return WIFI_ICON_OFF
        elif get_ssid() is None:
            return WIFI_ICON_DISCONNECTED
        else:
            return WIFI_ICON_CONNECTED
    except Exception:
        return WIFI_ICON_OFF


def main():
    # Get both statuses
    bt_icon, bt_label = get_bluetooth_status()
    wifi_icon = get_wifi_status()

    # Update both items in a single subprocess call
    cmd = [
        "sketchybar",
        "--set",
        "bluetooth",
        f"icon={bt_icon}",
        f"label={bt_label}",
        "--set",
        "wifi",
        f"icon={wifi_icon}",
        "label=",
    ]

    try:
        subprocess.run(cmd, timeout=5)
    except Exception as e:
        # Silently fail — items will show stale data
        pass


if __name__ == "__main__":
    main()
