# Kitty Terminal Configuration

Esta carpeta contiene la configuración del terminal Kitty para una experiencia óptima de desarrollo.

## Archivos

- `kitty.conf`: Configuración principal del terminal Kitty
- `README.md`: Este archivo de documentación

## Configuración Incluida

### 🎨 Tema y Apariencia
- **Fuente**: JetBrains Mono en tamaño 14pt
- **Tema de colores**: Dracula theme
- **Espaciado**: Padding y márgenes configurados para mejor legibilidad

### ⌨️ Atajos de Teclado
- `Ctrl+Shift+C`: Copiar al portapapeles
- `Ctrl+Shift+V`: Pegar desde portapapeles
- `Ctrl+Shift+T`: Nueva pestaña
- `Ctrl+Shift+W`: Cerrar pestaña
- `Ctrl+Shift+Prev/Anterior`: Navegar entre pestañas

### ⚙️ Otras Configuraciones
- **Shell**: Zsh configurado como shell por defecto
- **Editor**: Neovim configurado como editor por defecto
- **Scrollback**: 10,000 líneas de historial
- **Performance**: Optimizaciones para renderizado suave

## Instalación

1. Asegúrate de tener Kitty instalado:
   ```bash
   # macOS
   brew install kitty
   
   # Linux (Ubuntu/Debian)
   sudo apt install kitty
   
   # Linux (Arch)
   sudo pacman -S kitty
   ```

2. Enlazar esta configuración a tu directorio de configuración:
   ```bash
   ln -sf ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
   ```

3. Reiniciar Kitty o recargar la configuración con:
   ```
   Ctrl+Shift+F5
   ```

## Personalización

### Cambiar la fuente
Edita las siguientes líneas en `kitty.conf`:
```
font_family        NombreDeTuFuente
font_size          TamañoEnPuntos
```

### Cambiar el tema de colores
Reemplaza las líneas de colores en `kitty.conf` con tu tema preferido. Puedes encontrar temas predefinidos en la [documentación de Kitty](https://sw.kovidgoyal.net/kitty/conf/#color-scheme).

### Agregar nuevos atajos de teclado
Añade nuevas líneas al final del archivo:
```
map tu_combinacion tu_accion
```

## Tests

Para verificar que la configuración funciona correctamente, ejecuta los tests:

```bash
# Ejecutar tests de configuración
./test_kitty_config.sh
```

## Troubleshooting

### Problemas comunes:

1. **La fuente no se muestra correctamente**
   - Verifica que la fuente esté instalada en tu sistema
   - Reinicia Kitty completamente

2. **Los colores no se aplican**
   - Asegúrate de que no haya conflictos con otros archivos de configuración
   - Recarga la configuración con `Ctrl+Shift+F5`

3. **Los atajos de teclado no funcionan**
   - Verifica que no haya conflictos con otras aplicaciones
   - Revisa la sintaxis en el archivo de configuración

## Recursos Adicionales

- [Documentación oficial de Kitty](https://sw.kovidgoyal.net/kitty/)
- [Configuración avanzada](https://sw.kovidgoyal.net/kitty/conf/)
- [Temas de la comunidad](https://github.com/kovidgoyal/kitty-themes)

---

Configuración mantenida por: Statick
Última actualización: 2025-12-30