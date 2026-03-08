# Sketchybar Plugins

## Active Plugins (Used in sketchybarrc)

These 11 plugins are actively loaded by sketchybar. See `../sketchybarrc` for configuration.

### LEFT Side (2)
- **`front_app.py`** — Display current active application
- **`music.sh`** — Show now playing music info

### RIGHT Side (9)
- **`datetime.sh`** — Date and time display
- **`battery.py`** — Battery percentage and status
- **`wifi.py`** — WiFi connection status
- **`bluetooth.py`** — Bluetooth device status
- **`volume.py`** — Volume level
- **`ram.py`** — RAM usage percentage
- **`cpu.py`** — CPU usage percentage
- **`gpu.py`** — GPU usage percentage
- **`pomodoro.py`** — Pomodoro timer (25min work, 5min break, 4 cycles → 15min long break)

## Utilities
- **`colors.py`** — Color constants and utilities (imported by plugins)
- **`__pycache__/`** — Python bytecode cache

## Archived Plugins

All inactive, experimental, or duplicate plugins have been moved to `archive/` directory:
- Duplicate implementations (e.g., `battery.sh`, `cpu.sh` → Python versions preferred)
- Experimental features (mail, weather, news, system_stats)
- Unused scripts (github, meeting, media, happy_hacking)

To restore any archived plugin:
```bash
mv archive/plugin_name.{py,sh} .
```

---

**Last updated**: March 8, 2026 (SDD: modularize-sketchybar-plugins)
