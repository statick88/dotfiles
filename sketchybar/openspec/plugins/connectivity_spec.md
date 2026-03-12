# Especificación: Plugin Conectividad (WiFi & Bluetooth)

## REQUISITOS FUNCIONALES
### WiFi (Icono: 󰤨 / 󰤮)
- **Barra:** Icono dinámico según conexión. Color Azul ($BLUE) si hay IP, Gris ($DIM) si no.
- **Hover (Popup):**
    - IP Local.
    - Máscara de Subred.
    - Gateway (Router).
    - Velocidad en tiempo real (↓/↑).
- **Click:** Abrir 'Ajustes de WiFi'.

### Bluetooth (Icono: 󰂱 / 󰂯)
- **Barra:** Icono dinámico según dispositivos conectados. Color Magenta ($MAGENTA) si está ON, Gris ($DIM) si está OFF.
- **Hover (Popup):**
    - Estado (Encendido/Apagado).
    - Lista de dispositivos conectados.
- **Click:** Abrir 'Ajustes de Bluetooth'.

## REQUISITOS TÉCNICOS
- **Actualización:** Frecuencia de 1s para telemetría de red.
- **Persistencia:** Guardar bytes de red en `state/connectivity.json`.
- **Iconos:** Asegurar que el icono se dibuje SIEMPRE en la actualización de rutina.
- **Popup:** Control estricto de `mouse.entered` y `mouse.exited`.
