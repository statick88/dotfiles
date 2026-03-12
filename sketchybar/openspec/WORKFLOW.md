# Flujo de Trabajo Sketchybar (SDD + Proactividad)

Este documento define el ciclo de vida para la mejora de cada plugin en Sketchybar.

## Ciclo de Ejecución por Plugin

1. **Análisis:** Evaluación técnica del plugin actual usando SDD y generación de especificaciones (`specs`).
2. **Propuesta:** Sugerencias de cambio basadas en arquitectura, diseño, funcionalidad, seguridad y testing.
3. **Refinamiento:** Ajustes a la propuesta basados en feedback del usuario.
4. **Implementación (Surgical):** Generación de código si y solo si pertenece al plugin y no afecta a terceros.
5. **Validación:**
   - Guardar cambios.
   - Correr tests automáticos.
   - Corregir iterativamente hasta que todos los tests pasen.
   - Entrega de resumen para pruebas manuales.
6. **Cierre de Ciclo:** Si no hay más sugerencias, guardar memoria en Engram Server (o persistencia de contexto).
7. **Siguiente Plugin:** Repetir el ciclo con el próximo componente.

## Principios Guía
- **Seguridad:** No exponer datos sensibles, validación de entradas.
## Ingeniería de Calidad y Seguridad

- **Zero Trust Policy:** No se permiten rutas absolutas (`/Users/...`). Todititas las rutas deben ser relativas o detectadas dinámicamente mediante `shutil.which` o variables de entorno.
- **Detección de Secretos:** Prohibido subir API keys, IDs reales o información sensible al repositorio. Se usa `.gitignore` para proteger los archivos de estado (`*.json`).
- **Clean Architecture:** Separación estricta entre la lógica de obtención de datos (Python) y la visualización (Sketchybar).
- **Proactividad:** Buscar siempre soluciones funcionales probadas para implementaciones modernas.
- **Validación Empírica:** No se da por terminado un cambio sin tests exitosos.

