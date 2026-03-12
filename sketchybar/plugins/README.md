# Sketchybar Plugins

## Active Plugins (Python-based v4.0)

Todititos los plugins han sido modernizados a Python para mayor potencia y proactividad. Siguen el estándar **Premium Island**.

### LEFT Side (Multimedia & Context)
- **`front_app.py`** — Iconos dinámicos y telemetría de CPU/RAM por proceso (Activity Monitor style).
- **`audio.py`** — Controlador unificado de Radio (Exa, Boquerón, Aire Latino, Caravana). Click = Play/Pause.
- **`music.py`** — Integración con Spotify. Se oculta al pausar. Popup con barra de progreso y controles ⏮ ⏯ ⏭.

### RIGHT Side (System & Tools)
- **`datetime_plugin.py`** — Reloj y Calendario. Inmune a VPN (GMT-5 forzado). Caché asíncrono para zero-lag. Filtro de integridad (13:00).
- **`battery.py`** — Salud real vía `ioreg`. Notificaciones nativas de cargador.
- **`connectivity.py`** — Wi-Fi/BT minimalista. Modo **Hacking** (OPSEC) oculta datos sensibles. Tráfico dinámico en popup.
- **`system_stats.py`** — CPU, RAM, GPU y Disco optimizados (`vm_stat`). Semáforo visual (Verde/Amarillo/Rojo).
- **`pomodoro.py`** — Gestión de fases (Trabajo/Descanso) con barra de progreso visual. Sincronizado con Modos.
- **`volume.py`** — Control por scroll (+/- 5%) y toggle de Mute en popup.
- **`modes.py`** — **El Cerebro**. 5 perfiles profesionales (Statick, Estudiante, Facilitador, Hacking, Coding). Cambia colores, sonidos y perfiles de productividad.

## Utilities
- **`utils.py`** — Paleta de colores Gentleman, notificaciones, sonidos y gestión de estado.
- **`colors.py`** — Constantes de color compartidas.

## Quality & Security (Zero Trust)
- **Tests:** Suite completa en `tests/test_*.py`. TDD verificado.
- **No Hardcoding:** Rutas dinámicas y detección de interfaces.
- **Privacidad:** Datos sensibles protegidos en modos de auditoría.

---
**Last updated**: March 11, 2026 (v4.0 Premium Island Modernization)
