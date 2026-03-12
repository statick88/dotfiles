# Sketchybar Premium Island v4.0 🚀

Modernización completa de la barra de estado de macOS basada en el estándar **Premium Island**. Todititos los componentes han sido migrados de shell scripts a **Python v4.0** para ofrecer una experiencia proactiva, dinámica y de alto rendimiento, siguiendo los principios de **Clean Architecture** y **Zero Trust**.

## 🌟 Hitos de la Versión 4.0 (Hoy)

### 1. Cerebro de Modos Dinámicos (`modes.py`)
- Implementación de **5 perfiles profesionales** que cambian toditita la estética y funcionalidad:
  - **Statick (Normal)**: Configuración base balanceada.
  - **Estudiante**: Optimizado para la Maestría UCM (Azul Celeste, ciclos de 50m).
  - **Facilitador**: Perfil para Abacom/Codings (Ámbar, ciclos de 25m).
  - **Hacking**: Modo de auditoría (Red/Blue Team) con **OPSEC automático**.
  - **Coding**: Entorno de desarrollo puro (DevSecOps).
- Cada modo incluye **notificaciones proactivas** y **sonidos de sistema únicos** al activarse.

### 2. Calendario de Alta Integridad (`datetime_plugin.py`)
- **Inmunidad a VPN**: Forzado estricto a **GMT-5 (Ecuador)**.
- **Cero Retraso (Zero Lag)**: Sistema de caché asíncrono que refresca los datos cada 15 min en segundo plano. El popup aparece al instante.
- **Integridad de Datos**: Filtro de eventos para asegurar que solo se muestren registros íntegros (prioridad a su clase de las 13:00).

### 3. Inteligencia y Telemetría
- **Front App**: Mapeo dinámico de iconos y monitor de actividad en tiempo real (CPU/RAM) por proceso.
- **Conectividad**: Barra minimalista con telemetría de tráfico dinámica (↓/↑) y protección de datos sensibles en modo Hacking.
- **DevOps (Docker & K8s)**: Monitoreo de contenedores activos y salud de nodos Kubernetes directamente en la barra.
- **Intel (CVE & UCM)**: Ticker de vulnerabilidades críticas y seguimiento de hitos académicos de la Maestría.
- **Batería**: Salud detallada vía `ioreg` y notificaciones nativas de carga.
- **Audio**: Controlador unificado para Radio (Exa, Boquerón, Aire Latino, Caravana) con toggle de Play/Pause.

### 4. Estándar Premium Island
- Todititos los popups son listas verticales elegantes con fondo `$ISLAND_BG`, bordes `$ISLAND_BORDER` y `corner_radius=10`.
- Interacción fluida: apertura inmediata y cierre al milisegundo al quitar el puntero.

## 🧪 Calidad y Seguridad (Zero Trust)

- **TDD (Test Driven Development)**: Suite completa de pruebas en el directorio `tests/` validando toditita la lógica.
- **Clean Dots**: Eliminación de rutas absolutas (`/Users/...`) y datos hardcodeados. Uso de rutas relativas y detección dinámica de binarios.
- **Privacidad**: El modo Hacking oculta automáticamente SSIDs e IPs de la barra principal.

## 🛠️ Estructura de Archivos

```
sketchybar/
├── sketchybarrc           # ⚙️ Punto de entrada y estructura base
├── plugins/               # 🐍 Lógica de inteligencia en Python
│   ├── audio.py           # Gestión de radio y audio
│   ├── modes.py           # Orquestador de modos
│   ├── datetime_plugin.py # Reloj y Calendario GMT-5
│   ├── connectivity.py    # Red y OPSEC
│   ├── system_stats.py    # Telemetría de hardware
│   └── ...                # Ver plugins/README.md
├── tests/                 # 🧪 Pruebas unitarias y de integración
└── state/                 # 💾 Persistencia de estado (Zero Trust Gitignored)
```

---
**Desarrollado por**: Statick Medardo Saavedra García  
**Filosofía**: Gentleman Programming | Proactividad | Clean Architecture
