# Sketchybar Premium Island v4.0 🚀

Modernización completa de la barra de estado de macOS basada en el estándar **Premium Island**. Todititos los componentes han sido migrados a Python para ofrecer una experiencia proactiva, dinámica y de alto rendimiento.

## 🌟 Características Principales

- **Diseño Premium Island**: Popups verticales elegantes con fondo `$ISLAND_BG`, bordes `$ISLAND_BORDER` y `corner_radius=10`.
- **Modos de Sistema Dinámicos**: 5 perfiles profesionales (Statick, Estudiante, Facilitador, Hacking, Coding) que cambian la estética y el comportamiento de la barra al instante.
- **Calendario de Alta Integridad**: Forzado a GMT-5 (Ecuador), con caché asíncrono para apertura instantánea y filtrado de eventos de alta importancia.
- **Telemetría en Tiempo Real**: Monitor de actividad por proceso, tráfico de red dinámico y salud de batería detallada.
- **Zero Trust & OPSEC**: Eliminación de rutas hardcodeadas y protección automática de datos sensibles en modo Hacking.

## 🛠️ Estructura del Proyecto

```
sketchybar/
├── sketchybarrc           # ⚙️ Configuración principal (estática y estable)
├── plugins/               # 🐍 Motor de inteligencia (Python v4.0)
│   ├── modes.py           # El cerebro de la barra
│   ├── datetime_plugin.py # Reloj y Calendario (GMT-5)
│   ├── connectivity.py    # Wi-Fi y Bluetooth (OPSEC ready)
│   ├── audio.py           # Controlador de Radio unificado
│   ├── music.py           # Integración inteligente con Spotify
│   ├── system_stats.py    # CPU, RAM, GPU y Disco optimizados
│   ├── pomodoro.py        # Temporizador con barra de progreso
│   ├── volume.py          # Control por scroll y mute
│   └── front_app.py       # Telemetría de app frontal
├── tests/                 # 🧪 Suite de pruebas TDD completa
└── state/                 # 💾 Persistencia de estado local
```

## 📅 Log de Cambios (Modernización v4.0)

Hoy hemos transformado toditito el sistema siguiendo el ciclo de desarrollo agil y proactivo:

1.  **Refactorización Python**: Migración de todititos los scripts de shell a Python para permitir lógica compleja, caching y mejor manejo de errores.
2.  **Cerebro de Modos**: Implementación de un selector de modos proactivo que sincroniza colores, sonidos y perfiles de productividad (Pomodoro) según tu rol (Estudiante UCM, Facilitador, Hacking, etc.).
3.  **Calendario de Alta Disponibilidad**: Sistema de caché asíncrono que refresca la agenda cada 15 min en segundo plano, permitiendo que el popup aparezca al milisegundo sin lag.
4.  **Seguridad OPSEC**: El modo Hacking ahora limpia automáticamente la barra de información sensible de red.
5.  **Audio Proactivo**: Radio unificada con 4 estaciones validadas (Exa, Boquerón, Aire Latino, Caravana) y control de Play/Pause desde el icono.
6.  **Validación TDD**: Creación de una suite de tests en `tests/` que asegura la integridad de toditita la lógica implementada.

## 🚀 Instalación Rápida

1. Asegúrate de tener instalado Sketchybar y las fuentes necesarias (Nerd Fonts).
2. Clona este directorio en `~/.config/sketchybar`.
3. Instala las dependencias necesarias:
   ```bash
   brew install sketchybar jq gh gcalcli ffmpeg
   # Asegúrate de tener python3 disponible
   ```
4. Recarga la configuración:
   ```bash
   sketchybar --reload
   ```

## 🧪 Calidad y Testing

Este proyecto sigue una metodología de **Desarrollo Dirigido por Pruebas (TDD)**. Puedes ejecutar la suite de pruebas completa:

```bash
for test in tests/test_*.py; do python3 "$test"; done
```

---
**Desarrollado por**: Statick Medardo Saavedra García  
**Versión**: 4.0.0 (Premium Island Modernization)
