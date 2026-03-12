# Sketchybar Plugins

## Active Plugins (Python-based v4.0)

Todititos los plugins han sido modernizados a Python para mayor potencia y proactividad. Siguen el estándar **Premium Island**.

### LEFT Side (Multimedia & Context)
- **`front_app.py`** — Iconos dinámicos y telemetría de CPU/RAM por proceso (Activity Monitor style).
- **`audio.py`** — Controlador unificado de Radio (Exa, Boquerón, Aire Latino, Caravana). Click = Play/Pause.
- **`music.py`** — Integración con Spotify. Se oculta al pausar. Popup con barra de progreso y controles ⏮ ⏯ ⏭.

### RIGHT Side (System, Tools & Intel)
- **`datetime_plugin.py`** — Reloj y Calendario (GMT-5).
- **`battery.py`** — Salud real vía `ioreg`. Notificaciones nativas de cargador.
- **`connectivity.py`** — Wi-Fi/BT minimalista. OPSEC ready.
- **`docker.py`** — Monitor de contenedores activos.
- **`k8s.py`** — Estado de salud de nodos Kubernetes.
- **`cve_intel.py`** — Ticker de inteligencia de vulnerabilidades (CVEs críticos).
- **`ucm.py`** — Gestión de hitos académicos de la Maestría UCM.
- **`system_stats.py`** — CPU, RAM, GPU y Disco optimizados (`vm_stat`).
- **`pomodoro.py`** — Temporizador con barra de progreso.
- **`volume.py`** — Control por scroll y mute.
- **`modes.py`** — El Cerebro de la barra.

## Utilities
- **`utils.py`** — Paleta de colores Gentleman, notificaciones, sonidos y gestión de estado.
- **`colors.py`** — Constantes de color compartidas.

## Quality & Security (Zero Trust)
- **Tests:** Suite completa en `tests/test_*.py`. TDD verificado.
- **No Hardcoding:** Rutas dinámicas y detección de interfaces.
- **Privacidad:** Datos sensibles protegidos en modos de auditoría.

---
**Last updated**: March 11, 2026 (v4.0 Premium Island Modernization)
