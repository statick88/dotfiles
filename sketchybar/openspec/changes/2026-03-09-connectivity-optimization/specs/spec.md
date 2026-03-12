# Especificación de Conectividad (v4.0.0)

## Propósito
Gestionar la visualización de métricas de red y bluetooth, permitiendo la interacción para cambio de redes y gestión de dispositivos sin bloqueos de UI.

## Requisitos de Arquitectura
1.  **Máquina de Estados:** El plugin DEBE reconocer tres estados:
    - `IDLE`: Solo icono en la barra.
    - `INFO`: Hover activo, muestra IP, Gateway, Velocidad y Signal.
    - `MENU`: Clic activo, oculta INFO y muestra lista de redes/dispositivos.
2.  **Desacoplamiento:** La obtención de datos DEBE estar separada de la manipulación de Sketchybar.
3.  **Persistencia:** El estado de `menu_mode` DEBE persistir en JSON para que las actualizaciones periódicas (1s) no interrumpan la interacción del usuario.

## Requisitos de Funcionalidad
### WiFi
- **Telemetría:** IP Local, IP Gateway, RSSI (Señal en dBm), Velocidad (↓/↑).
- **Escaneo:** Lista de redes preferidas (nombres reales) y opción de apertura de panel de sistema.
- **Conexión:** Diálogo de contraseña seguro y conexión asíncrona.

### Bluetooth
- **Dispositivos:** Nombre, Tipo (Icono) y Batería (si aplica).

## Requisitos de Diseño
- **Exclusividad:** El menú de redes DEBE reemplazar visualmente a los detalles de IP/Velocidad al hacer clic.
- **Performance:** Todas las llamadas a Sketchybar DEBEN agruparse en un solo proceso (batch) para evitar el "frizado" de la barra.
