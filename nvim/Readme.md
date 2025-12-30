# Neovim Configuration: Statick 🚀

Esta es la configuración personalizada de Neovim desarrollada por **Diego Medardo Saavedra García**, profesional de TI con más de 8 años de experiencia en desarrollo **Fullstack** y **Educación Superior**. Este entorno está optimizado para la transferencia de conocimiento, la transparencia técnica y el desarrollo profesional.

---

## 🎯 **Guía Rápida para Principiantes**

### 📖 **Comandos Básicos de Neovim**

| Modo | Comando | Acción | Descripción |
| --- | --- | --- | --- |
| **Normal** | `i` | Entrar a modo Insert | Permite escribir texto |
| **Normal** | `Esc` | Salir a modo Normal | Volver al modo de comandos |
| **Normal** | `:w` | Guardar archivo | Write - guardar cambios |
| **Normal** | `:q` | Salir | Quit - salir de nvim |
| **Normal** | `:wq` | Guardar y salir | Write & Quit |
| **Normal** | `:q!` | Salir sin guardar | Forzar salida sin guardar |
| **Normal** | `h,j,k,l` | Mover cursor | Izquierda, Abajo, Arriba, Derecha |
| **Normal** | `w` | Siguiente palabra | Mover a la siguiente palabra |
| **Normal** | `b` | Anterior palabra | Mover a la palabra anterior |
| **Normal** | `dd` | Borrar línea | Eliminar línea actual |
| **Normal** | `yy` | Copiar línea | Yank - copiar línea actual |
| **Normal** | `p` | Pegar | Paste después del cursor |
| **Normal** | `u` | Deshacer | Undo último cambio |
| **Normal** | `Ctrl+r` | Rehacer | Redo último deshecho |

### 🗂️ **Gestión de Archivos y Directorios**

| Comando | Acción | Ejemplo |
| --- | --- | --- |
| `:e archivo.txt` | Editar archivo | `:e main.py` |
| `:w nombre.txt` | Guardar como | `:w backup.txt` |
| `:mkdir nombre` | Crear directorio | `:mkdir src` |
| `:!mkdir nombre` | Crear directorio (shell) | `:!mkdir components` |
| `:!ls -la` | Listar archivos (shell) | Ver archivos del directorio |
| `:cd ruta` | Cambiar directorio | `:cd ~/projects` |
| `:pwd` | Mostrar directorio actual | Print Working Directory |
| `:o .` | Abrir explorador | Abrir Neo-tree |

---

## 🛠️ **Flujo de Trabajo con Tmux**

### 🪟 **Comandos Básicos de Tmux**

| Comando | Acción | Descripción |
| --- | --- | --- |
| `tmux` | Iniciar nueva sesión | Crea nueva sesión tmux |
| `tmux new -s nombre` | Sesión con nombre | `tmux new -s proyecto` |
| `tmux ls` | Listar sesiones | Muestra todas las sesiones |
| `tmux attach -t nombre` | Unir a sesión | `tmux attach -t proyecto` |
| `Ctrl+b c` | Nueva ventana | Crear nueva ventana |
| `Ctrl+b ,` | Renombrar ventana | Cambiar nombre de ventana |
| `Ctrl+b n/p` | Siguiente/Anterior ventana | Navegar entre ventanas |
| `Ctrl+b %` | Dividir vertical | Split vertical |
| `Ctrl+b "` | Dividir horizontal | Split horizontal |
| `Ctrl+b flechas` | Mover entre panes | Navegar entre paneles |
| `Ctrl+b x` | Cerrar pane | Eliminar pane actual |
| `tmux kill-session -t nombre` | Eliminar sesión | Cerrar sesión completa |

### 🔄 **Navegación Neovim + Tmux (Configurada)**

| Comando | Acción |
| --- | --- |
| `Ctrl+h/j/k/l` | Navegar entre splits de nvim y panes de tmux |
| `Ctrl+Shift+flechas` | Redimensionar tmux panes desde nvim |

## 🛠️ Stack Tecnológico y Componentes

| Categoría | Herramienta | Descripción |
| --- | --- | --- |
| **Gestor de Plugins** | [Lazy.nvim](https://github.com/folke/lazy.nvim) | Instalación rápida, gestión de dependencias y carga diferida. |
| **LSP Management** | [Mason.nvim](https://github.com/williamboman/mason.nvim) | Gestión centralizada de servidores LSP, linters y formateadores. |
| **Sintaxis** | [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis avanzado y análisis de código basado en AST. |
| **Explorador** | [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Navegación de archivos visual y eficiente dentro del editor. |
| **Markdown** | [Render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Visualización estética in-editor para documentación técnica. |
| **IA Asistente** | [OpenCode.nvim](https://github.com/NickvanDyke/opencode.nvim) | Asistente de IA para desarrollo, explicación de código y refactorización. |
| **Integración Terminal** | [Tmux.nvim](https://github.com/aserowy/tmux.nvim) | Navegación seamless entre Neovim splits y tmux panes. |

---

## 🎮 **Guía de Plugins - Cómo Usar Cada Uno**

### 🔍 **Telescope.nvim - Búsqueda Inteligente**

**¿Qué hace?** Es un buscador potente para encontrar archivos, texto y comandos.

| Comando | Acción | Ejemplo de Uso |
| --- | --- | --- |
| `<leader>pf` | Buscar archivos | Escribe el nombre del archivo que buscas |
| `<leader>pg` | Buscar texto en archivos | Encuentra dónde aparece una palabra en el proyecto |
| `<leader>pb` | Buscar buffers | Navegar entre archivos abiertos |
| `<leader>ps` | Buscar símbolos | Encontrar funciones, variables en archivo actual |
| `<leader>ph` | Buscar help | Buscar documentación de comandos vim/nvim |

**Flujo de trabajo típico:**
1. Presiona `<leader>pf`
2. Escribe parte del nombre del archivo
3. Usa flechas para seleccionar
4. Presiona Enter para abrir

### 🌳 **Neo-tree.nvim - Explorador de Archivos**

**¿Qué hace?** Es el explorador de archivos visual, similar al de VSCode.

| Comando | Acción | Uso |
| --- | --- | --- |
| `<leader>pv` | Abrir/cerrar explorador | Principal para ver archivos |
| `a` | Crear archivo/directorio | En el explorador, crea nuevo |
| `d` | Borrar archivo/directorio | Elimina lo seleccionado |
| `r` | Renombrar archivo/directorio | Cambia nombre del archivo |
| `y` | Copiar archivo | Copia a portapapeles |
| `x` | Cortar archivo | Mueve archivo |
| `p` | Pegar archivo | Pega archivo copiado/cortado |
| `Tab` | Cambiar foco | Alterna entre archivos y contenido |

**Consejo:** Usa `<leader>pv` para abrir el explorador y `Tab` para cambiar entre el explorador y el editor.

### 🤖 **OpenCode.nvim - Asistente de IA**

**¿Qué hace?** Es como tener un programador experto disponible para ayudarte con tu código.

| Comando | Acción | Cuándo usarlo |
| --- | --- | --- |
| `<leader>oA` | Abrir asistente IA | Para preguntas generales de programación |
| `<leader>oa` | Preguntar sobre cursor | Para entender código específico |
| `<leader>oe` | Explicar código | Cuando no entiendes qué hace un código |
| `<leader>od` | Debuggear código | Cuando tienes errores que no entiendes |
| `<leader>or` | Refactorizar código | Para mejorar calidad del código |
| `<leader>ot` | Toggle ventana | Mostrar/ocultar panel de IA |

**Ejemplos de uso práctico:**
1. Coloca el cursor sobre una función compleja
2. Presiona `<leader>oe` 
3. Pregunta: "¿Qué hace esta función y cómo funciona?"
4. La IA te dará una explicación detallada

### 🪟 **Tmux.nvim - Integración Terminal**

**¿Qué hace?** Te permite moverte entre Neovim y Tmux como si fuera una sola aplicación.

| Comando | Acción | Ventaja |
| --- | --- | --- |
| `Ctrl+h` | Mover izquierda | Sin levantar las manos del home row |
| `Ctrl+j` | Mover abajo | Navegación fluida entre paneles |
| `Ctrl+k` | Mover arriba | Consistente entre tmux y nvim |
| `Ctrl+l` | Mover derecha | Elimina la necesidad de Ctrl+b en tmux |
| `Ctrl+Shift+flechas` | Redimensionar paneles | Ajusta tamaño desde nvim |

**Consejo:** Con esto puedes tener Neovim en un lado y terminal en otro, y moverte entre ellos sin cambiar atajos.

### 🌲 **Treesitter - Resaltado de Código**

**¿Qué hace?** Da colores inteligentes al código basado en su estructura, no solo texto.

| Característica | Beneficio |
| --- | --- |
| Resaltado sintáctico preciso | Entiende la estructura del código |
| Navegación de código | Usa `]c` y `[c` para moverse entre funciones |
| Refactorización inteligente | Sabe qué es función, variable, etc. |

**Consejo:** Treesitter funciona automáticamente, solo necesita que los lenguajes estén instalados.

### 🔤 **Autopairs - Pares Automáticos**

**¿Qué hace?** Cierra automáticamente paréntesis, llaves, comillas, etc.

| Acción | Resultado |
| --- | --- |
| Escribe `(` | Se convierte en `()` con cursor dentro |
| Escribe `{` | Se convierte en `{}` con cursor dentro |
| Escribe `"` | Se convierte en `""` con cursor dentro |
| Presiona `Backspace` dentro de par | Borra ambos paréntesis |

**Consejo:** Ayuda a escribir código más rápido y evita errores de paréntesis no cerrados.

### 🎨 **Colorscheme - Tema Catppuccin**

**¿Qué hace?** Da un aspecto visual atractivo y profesional a Neovim.

| Característica | Ventaja |
| --- | --- |
| Diseño moderno | Colores cuidadostamente seleccionados |
| Alto contraste | Fácil de leer por largas horas |
| Consistencia | Mismo esquema en todos los lenguajes |

**Consejo:** Si quieres cambiar de tema, puedes modificar este archivo.

### 💬 **Completions - Autocompletado Inteligente**

**¿Qué hace?** Sugiere palabras y código mientras escribes.

| Comando | Acción |
| --- | --- |
| `Ctrl+Space` | Activar sugerencias |
| `Tab/Enter` | Aceptar sugerencia |
| `Ctrl+n/p` | Navegar entre opciones |
| `Esc` | Cancelar sugerencias |

**Consejo:** Funciona mejor si tienes configurado LSP.

### 🔧 **LSP - Servidor de Lenguaje**

**¿Qué hace?** Proporciona inteligencia avanzada del lenguaje que estás usando.

| Característica | Beneficio |
| --- | --- |
| `gd` | Ir a definición de función/variable |
| `gr` | Buscar referencias |  
| `K` | Mostrar documentación |
| `[d` | Ir al diagnóstico anterior |
| `]d` | Ir al siguiente diagnóstico |
| `:LspInfo` | Ver servidores activos |

**Lenguajes configurados:**
- `lua_ls` - Para archivos Lua
- `ts_ls` - Para TypeScript/JavaScript
- `pyright` - Para Python
- `html`, `cssls`, `tailwindcss` - Para desarrollo web

**Consejo:** LSP es lo que transforma Neovim en un IDE completo.

### 📝 **Markdown - Renderizado**

**¿Qué hace?** Muestra tus archivos Markdown con formato visual atractivo.

| Comando | Acción |
| --- | --- |
| Abrir archivo .md | Se renderiza automáticamente |
| Editar archivo .md | Alterna entre modo edición y vista previa |

**Consejo:** Ideal para tomar notas o documentar proyectos.

### 🌈 **Git - Control de Versiones Integrado**

**¿Qué hace?** Integra comandos de Git directamente en Neovim.

| Comando | Acción |
| --- | --- |
| `:Git status` | Ver estado de archivos |
| `:Git add .` | Agregar todos los cambios |
| `:Git commit -m "mensaje"` | Hacer commit |
| `:Git push` | Subir cambios |
| `]c` / `[c` | Navegar entre cambios (hunks) |
| `<leader>hs` | Stage cambio actual |
| `<leader>hr` | Reset cambio actual |

**Consejo:** Con esto no necesitas salir de Neovim para usar Git. |

---

## 📂 Estructura del Proyecto

La configuración adopta una arquitectura modular. El punto de entrada `init.lua` delega la carga a módulos específicos ubicados en el directorio `lua/statick/`, asegurando una separación clara entre la configuración base y las extensiones.

A continuación se detalla la estructura exacta del sistema de archivos:

```
~/.config/nvim/
├── init.lua                # Punto de entrada principal: inicializa Lazy.nvim y carga módulos.
├── lazy-lock.json          # Instantánea de versiones exactas de los plugins (garantiza reproducibilidad).
├── Readme.md               # Documentación del proyecto.
└── lua/
    └── statick/            # Namespace principal del usuario.
        ├── core/           # Configuraciones fundamentales de Neovim.
        │   ├── options.lua # Opciones generales (vim.opt).
        │   └── keymaps.lua # Mapeos de teclado globales.
        └── plugins/        # Especificaciones modulares de cada plugin.
            ├── autopairs.lua
            ├── colorscheme.lua
            ├── completions.lua
            ├── git.lua
            ├── lsp.lua     # Configuración crítica de Mason y lspconfig.
            ├── markdown.lua
            ├── neotree.lua
            ├── opencode.lua # Asistente de IA para desarrollo de código.
            ├── telescope.lua
            ├── tmux.lua     # Integración con tmux para terminal workflow.
            └── treesitter.lua

```

*Estructura visual basada en la implementación actual.*

---

## 🚀 Instalación y Requisitos

Para garantizar la veracidad y el correcto funcionamiento del entorno, asegúrese de cumplir con los siguientes requisitos previos:

* **Neovim >= 0.9.0** (Requerido para características modernas de Lua JIT).
* **Git** (Necesario para que Lazy.nvim clone repositorios).
* **Compilador C** (gcc o clang, requerido por Treesitter para compilar parsers).
* **Nerd Font** instalada en su terminal (necesario para los iconos de Neo-tree y línea de estado).

### Pasos de despliegue:

1. **Respaldar configuración existente (si aplica):**
```bash
mv ~/.config/nvim ~/.config/nvim.bak

```


2. **Clonar el repositorio:**
```bash
git clone <URL_DE_TU_REPOSITORIO> ~/.config/nvim

```


3. **Inicialización automática:**
Inicie Neovim (`nvim`). El gestor `Lazy.nvim` detectará la ausencia de plugins y comenzará la instalación y compilación automática de todos los componentes definidos en `lua/statick/plugins/`. Espere a que el proceso finalice.

---

## 📋 Principios de Diseño

* **Transparencia:** Cada plugin tiene su propio archivo de configuración aislado, lo que facilita la auditoría y el ajuste fino sin afectar otras partes del sistema.
* **Precisión Técnica:** La configuración de LSP está ajustada para proporcionar diagnósticos y autocompletado precisos para el stack definido (Lua, Web, Python), evitando configuraciones globales ruidosas.
* **Integración Terminal:** Flujo de trabajo optimizado entre Neovim y tmux para desarrollo eficiente con navegación seamless entre splits y panes.
* **Asistencia IA:** Integración con OpenCode para asistencia inteligente en desarrollo, debugging y refactorización de código.
* **Entorno Educativo:** La claridad del código y la estructura modular están pensadas para servir como ejemplo en entornos de enseñanza universitaria.

---

## 🎯 Plugins Recientes y Funcionalidades

### OpenCode.nvim - Asistente de IA

Integración con OpenCode para asistencia inteligente durante el desarrollo:

**Keymaps principales:**
- `<leader>oA` - Abrir prompt de OpenCode
- `<leader>oa` - Preguntar sobre el código bajo el cursor
- `<leader>ot` - Toggle de ventana de OpenCode
- `<leader>on` - Nueva sesión
- `<leader>oe` - Explicar código en el cursor
- `<leader>od` - Ayuda con debugging en cursor
- `<leader>or` - Refactorizar código en cursor

### Tmux.nvim - Integración Terminal

Navegación seamless entre Neovim y tmux:

**Navegación:**
- `Ctrl+h/j/k/l` - Moverse entre tmux panes y neovim splits
- `Ctrl+Direction Keys` - Redimensionar tmux panes

**Características:**
- Sincronización de clipboard bidireccional
- Navegación cíclica cuando no hay más splits
- Redimensionado de panes desde Neovim

---

## 🎯 **Flujo de Trabajo Diario - Ejemplo Práctico**

### 🌅 **Iniciar el Día:**

```bash
# 1. Iniciar tmux y nvim
tmux new -s proyecto
cd ~/mi-proyecto
nvim .
```

### 📝 **Trabajando en Código:**

```bash
# 1. Abrir archivo existente
<leader>pf  # Buscar archivo main.py

# 2. Crear nuevo archivo
:a nuevo_componente.py

# 3. Navegar por código
gd          # Ir a definición de función
Ctrl+o      # Volver atrás
K           # Ver documentación

# 4. Usar IA para entender código
<leader>oe  # Explicar código bajo cursor

# 5. Debugear con ayuda de IA
<leader>od  # Pedir ayuda con error

# 6. Refactorizar código
<leader>or  # Sugerir mejoras
```

### 🔄 **Working con Terminal:**

```bash
# En Neovim:
:term       # Abrir terminal integrada
Ctrl+h/j/k/l # Navegar entre nvim y tmux

# En Tmux:
Ctrl+b c    # Nueva ventana para testing
Ctrl+b %    # Dividir vertical para ver logs
Ctrl+b "    # Dividir horizontal para comandos
```

### 📊 **Usar Git Integrado:**

```bash
# Ver cambios:
]c [c       # Navegar entre cambios

# Stage/unstaged:
<leader>hs  # Agregar cambio actual
<leader>hr  # Descartar cambio actual

# Commit:
:Git commit -m "feat: añadir nueva funcionalidad"
:Git push
```

---

## ⚡ **Quick Start - Comandos Esenciales**

| Categoría | Comando | Acción | Primer Recordatorio |
| --- | --- | --- | --- |
| **Búsqueda** | `<leader>pf` | Buscar archivos | "Project Files" |
| **Explorador** | `<leader>pv` | Abrir Neo-tree | "Project View" |
| **IA Ayuda** | `<leader>oe` | Explicar código | "OpenCode Explain" |
| **IA Debug** | `<leader>od` | Debug con IA | "OpenCode Debug" |
| **Navegación** | `gd` | Ir a definición | "Go to Definition" |
| **Documentación** | `K` | Ver docs | "Keep" (mantener pulsado) |
| **Terminal** | `:term` | Abrir terminal | "Terminal" |
| **Git Status** | `:Git status` | Ver estado git | "Git" |

---

## 🔧 **Resolución de Problemas Comunes**

### ❓ **"No funciona el autocompletado"**
```bash
# Verificar LSP está corriendo
:LspInfo

# Si no está, reiniciar nvim y esperar a que se instalen los servidores
```

### ❓ **"No se ven los colores"**
```bash
# Verificar Treesitter tiene parsers para tu lenguaje
:TSInstallInfo

# Instalar parser si falta
:TSInstall python
```

### ❓ **"No funciona la navegación tmux"**
```bash
# Asegúrate de estar dentro de una sesión tmux
tmux

# Verificar tmux está corriendo
tmux ls
```

### ❓ **"La IA no responde"**
```bash
# Abrir OpenCode manualmente
<leader>oA

# Verificar tienes conexión a internet
# Configurar tu API key si es necesario
```

---

## 💡 **Consejos para Máxima Productividad**

1. **Configura tu leader key**: `<leader>` es `Espacio` por defecto
2. **Usa frecuentemente `<leader>pf`**: Es más rápido que navegar manualmente
3. **Aprovecha la IA**: No sufras entendiendo código complejo, pregunta
4. **Mantén tmux abierto**: Un solo terminal con múltiples ventanas
5. **Usa Git integrado**: No salgas de nvim para hacer commits
6. **Personaliza gradualmente**: Añade tus propios atajos con el tiempo
7. **Practica los comandos básicos**: La velocidad viene con la práctica

---

## 📚 **Recursos Adicionales**

- **Documentación oficial Neovim**: `:help`
- **Vimtutor**: Ejecuta `vimtutor` en terminal
- **Guía de comandos LSP**: `:help lsp`
- **Documentación Telescope**: `:help telescope`
- **Guía Treesitter**: `:help treesitter`
