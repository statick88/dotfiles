# Especificación de Estadísticas del Sistema (v2.0.0)

## Propósito
Visualizar el rendimiento del hardware (CPU, RAM, GPU, DISK) con métricas rápidas en la barra y detalles técnicos en popups verticales.

## Requisitos de Funcionalidad
### CPU
- Barra: % de uso.
- Popup: Carga media (1, 5, 15 min).

### RAM
- Barra: % de presión/uso.
- Popup: Usado / Total en GB.

### GPU
- Barra: % de actividad (si disponible).
- Popup: Modelo del chip.

### DISK (NUEVO)
- Barra: % de ocupación del volumen raíz (`/`).
- Popup: 
    - Espacio Usado (GB)
    - Espacio Libre (GB)
    - Tamaño Total (GB)

## Requisitos de Diseño
- **Consistencia:** Todos los popups deben seguir el prefijo `.info.*` y activarse por hover local.
- **Eficiencia:** Usar `df -h` para el disco, que es una operación de bajo costo.
