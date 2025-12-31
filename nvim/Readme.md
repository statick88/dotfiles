# Neovim Configuration: Statick 🚀

Esta es la configuración personalizada de Neovim desarrollada por **Statick Medardo Saavedra García**, profesional de TI con más de 8 años de experiencia en desarrollo **Fullstack** y **Educación Superior**. Este entorno está optimizado para la transferencia de conocimiento, la transparencia técnica y el desarrollo profesional.

---

## 📋 **Tabla de Contenidos**

- [🎯 Guía Rápida para Principiantes](#-guía-rápida-para-principiantes)
- [🛠️ Stack Tecnológico](#️-stack-tecnológico)
- [🎮 Guía de Plugins](#-guía-de-plugins)
- [📊 Quarto](#-quarto)
- [📂 Estructura del Proyecto](#-estructura-del-proyecto)
- [🚀 Instalación](#-instalación)
- [⚡ Quick Start](#-quick-start)
- [🔧 Solución de Problemas](#-solución-de-problemas)

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

---

## 🛠️ **Stack Tecnológico**

| Categoría | Herramienta | Descripción |
| --- | --- | --- |
| **Gestor de Plugins** | [Lazy.nvim](https://github.com/folke/lazy.nvim) | Instalación rápida, gestión de dependencias y carga diferida. |
| **Ayuda Visual** | [Which-key.nvim](https://github.com/folke/which-key.nvim) | Muestra un menú visual de todos los atajos disponibles. |
| **LSP Management** | [Mason.nvim](https://github.com/williamboman/mason.nvim) | Gestión centralizada de servidores LSP, linters y formateadores. |
| **Sintaxis** | [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis avanzado y análisis de código basado en AST. |
| **Explorador** | [Neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | Navegación de archivos visual y eficiente dentro del editor. |
| **Markdown** | [Render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Visualización estética in-editor para documentación técnica. |
| **Documentos Científicos** | [Quarto.nvim](https://github.com/quarto-dev/quarto-nvim) | Integración completa para documentos Quarto (.qmd) con ejecución de código. |
| **Búsqueda** | [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Buscador fuzzy potente para archivos, texto y comandos. |
| **Integración Terminal** | [Tmux.nvim](https://github.com/aserowy/tmux.nvim) | Navegación seamless entre Neovim splits y tmux panes. |
| **Git** | [Gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Indicadores visuales de cambios Git en el gutter. |
| **Autocompletado** | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Sistema de autocompletado inteligente. |
| **Tema** | [Tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tema visual profesional Matrix-inspired. |

---

## 🚀 **Plugins Especializados - Perfil FullStack Developer**

Basado en el perfil de **Statick88** (FullStack Developer + Docente), se agregaron plugins especializados con **lazy loading inteligente**:

### 📊 **Productividad** - `productivity.lua`
**Solo se cargan cuando se abren archivos relevantes.**

| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **Flash.nvim** | Navegación rápida con highlights | `s` / `S` |
| **nvim-surround** | Manipular texto alrededor | `ys` / `ds` / `cs` |
| **todo-comments.nvim** | Highlight TODO, FIXME, etc. | `]t` / `[t` |
| **indent-blankline.nvim** | Líneas de indentación visual | Automático |
| **nvim-colorizer** | Muestra colores hexadecimales | Automático |
| **Trouble.nvim** | Lista de diagnósticos | `<leader>xx`, `<leader>xX`, `<leader>cs` |
| **Comment.nvim** | Comentarios inteligentes | `gc` / `gb` |
| **mini.pairs** | Autopares mejorado | Automático |

### 🌐 **Web Development** - `web-dev.lua`
**Solo se cargan cuando se detectan archivos web (HTML, CSS, JS/TS).**

| Plugin | Descripción |
| --- | --- |
| **Emmet** | Expansión rápida de HTML/CSS | Automático en insert |
| **Tailwind Tools** | Autocompletado para clases Tailwind | Automático |
| **React/Next.js Snippets** | Snippets para React/Next.js | Automático |
| **TypeScript Tools** | Herramientas adicionales para TS | Automático |
| **nvim-ts-autotag** | Cerrar HTML/XML tags | Automático |
| **nvim-closetag** | Auto-close HTML/XML tags | Automático |

**Soporta:** React, Next.js, TypeScript, HTML, CSS, Tailwind, Node.js, Vue, Svelte

### 🐍 **Python Development** - `python-dev.lua`
**Solo se carga cuando se detectan archivos Python.**

| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **venv-selector.nvim** | Selector de entornos virtuales | `<leader>vs` |
| **Neotest-python** | PyTest integration | `<leader>tr`, `<leader>tf`, `<leader>ts`, `<leader>to` |
| **neogen** | Generador de docstrings | `<leader>nd` |
| **Django templates** | Soporte para plantillas Django | Automático |

**Soporta:** Django, FastAPI, PyTest, Virtual Envs

### ⚙️ **DevOps & Databases** - `git-docker.lua`
**Solo se cargan cuando se detectan archivos Docker/YAML.**

| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **lazygit.nvim** | Interfaz TUI para Git | `<leader>gg` |
| **diffview.nvim** | Visualización de diffs mejorada | `<leader>gvo`, `<leader>gvc`, `<leader>gvf`, `<leader>gvk` |
| **git-conflict.nvim** | Resolver conflictos Git | `<leader>gco`, `<leader>gct`, `<leader>gcb`, `<leader>gc0`, `<leader>gcn`, `<leader>gcp` |
| **blamer.nvim** | Git blame inline | Automático |
| **nui-docker.nvim** | UI para Docker con NUI | `<leader>du` |
| **Dockerfile.vim** | Syntax highlighting para Docker | Automático |
| **yaml-companion.nvim** | Schema validation YAML/K8s | Automático |
| **vim-helm** | Soporte para Helm charts | Automático |

**Soporta:** Docker, Docker Compose, Kubernetes, Terraform, Helm, Ansible

### 📱 **Flutter & Mobile Dev** - `flutter-dev.lua`
**Solo se carga cuando se detectan archivos Dart o Flutter.**

| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **flutter-tools.nvim** | Herramientas para Flutter | `<leader>F`, `<leader>D`, `<leader>Q`, `<leader>R`, `<leader>H` |
| **dartls** | LSP para Dart | Automático |

**Soporta:** Flutter, Dart, desarrollo móvil multiplataforma

### 🐛 **Debugger** - `debugger.lua` (Temporalmente Desactivado)
| Plugin | Descripción |
| --- | --- |
| **nvim-dap** | DAP (Debug Adapter Protocol) | `F5`, `F10`, `F11`, `F12`, `<leader>b`, `<leader>du` |

**Nota:** Desactivado temporalmente. Puedo activarlo eliminando el comentario del plugin.

### 🔬 **Data Science** - `data-science.lua` (Temporalmente Desactivado)
| Plugin | Descripción |
| --- | --- |
| **jupytext.nvim** | Conversión Jupyter <-> Markdown | Automático |
| **vim-csv** | Visualizador de CSV | Automático |

**Nota:** Desactivado temporalmente por dependencias complejas.

### ✅ **Testing** - `testing.lua`
| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **vim-test** | Test runner universal | Automático según filetype |
| **neotest** | Test runner multi-lenguaje | Automático según filetype |

**Soporta:** Python, JavaScript, TypeScript, Ruby, Rust, Go, Zig, Lua

### 🔀 **Git Avanzado** - `git-docker.lua`**
| Plugin | Descripción | Keymap |
| --- | --- | --- |
| **lazygit.nvim** | Interfaz TUI para Git | `<leader>gg` |
| **diffview.nvim** | Visualización de diffs mejorada | `<leader>gvo`, `<leader>gvc` |
| **git-conflict.nvim** | Resolver conflictos Git | `<leader>gco`, `<leader>gct`, `<leader>gcb`, `<leader>gc0`, `<leader>gcn`, `<leader>gcp` |
| **blamer.nvim** | Git blame inline | Automático |
| **git-browse** | Abrir repo en navegador | `<leader>go` |

**Características:**
- Integración mejorada con Git workflows
- Resolución de conflictos simplificada
- Navegación de repositorios
- Git blame inline automático

---

---

## 🚀 **Plugins Especializados - Perfil FullStack Developer**

Basado en el perfil de **Statick88** (FullStack Developer + Docente), se agregaron plugins especializados para:

### 📊 **Productividad** - `productivity.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **Flash.nvim** | Navegación rápida con highlights | `s` / `S` |
| **nvim-surround** | Manipular texto alrededor (comillas, paréntesis) | `ys`, `ds`, `cs` |
| **todo-comments.nvim** | Highlight TODO, FIXME, etc. | `]t` / `[t` |
| **indent-blankline.nvim** | Líneas de indentación visual | Automático |
| **nvim-colorizer** | Muestra colores en código hexadecimal | Automático |
| **Trouble.nvim** | Lista de diagnósticos y referencias | `<leader>xx` |
| **Comment.nvim** | Comentarios inteligentes | `gc` / `gb` |
| **mini.pairs** | Autopares mejorado | Automático |
| **mini.ai** | LLM de texto para manipulación | Automático |

**Keymaps:**
- `s` / `S` - Flash navigation
- `]t` / `[t` - TODO navigation
- `<leader>xx` - Trouble diagnostics
- `gc` - Toggle comment

### 🌐 **Web Development** - `web-dev.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **Emmet** | Expansión rápida de HTML/CSS | `<C-y>,` en insert |
| **Tailwind Tools** | Autocompletado para clases Tailwind | Automático |
| **React Snippets** | Snippets para React/Next.js | Automático |
| **TypeScript Tools** | Herramientas adicionales para TS | Automático |
| **nvim-ts-autotag** | Cerrar HTML/XML tags automáticamente | Automático |
| **nvim-closetag** | Auto-close HTML/XML tags | Automático |

**Características:**
- Soporte para React, Next.js, TypeScript
- Emmet para HTML/CSS
- Tailwind CSS autocompletado
- ESLint y Prettier integration

### 🐍 **Python Development** - `python-dev.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **venv-selector.nvim** | Selector de entornos virtuales | `<leader>vs` |
| **Neotest-python** | PyTest integration | `<leader>tr`, `<leader>tf` |
| **neogen** | Generador de docstrings | `<leader>nd` |
| **Django templates** | Soporte para plantillas Django | Automático |

**Características:**
- Integración con Django y FastAPI
- PyTest integration
- Generación automática de docstrings
- Selector de entornos virtuales

### ⚙️ **DevOps & Databases** - `devops.lua`

| Plugin | Descripción | Soporta |
| --- | --- | --- |
| **Dockerfile.vim** | Syntax highlighting para Docker | Dockerfile, docker-compose |
| **web-tools.nvim** | Validación YAML/JSON | Kubernetes, Helm, Terraform |
| **yaml-companion** | Schema validation para YAML | Kubernetes, Ansible |
| **vim-helm** | Soporte para Helm charts | Helm |
| **vim-terraform** | Soporte para Terraform | Terraform, HCL |
| **ansible-vim** | Soporte para Ansible | Ansible playbooks |

**Keymaps:**
- `<leader>k` - Instant K8s
- `<leader>db` - Database UI
- `<leader>tf` - Terraform commands

### 📱 **Flutter & Mobile Dev** - `flutter-dev.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **flutter-tools.nvim** | Herramientas para Flutter | `<leader>F`, `<leader>D` |
| **dartls** | LSP para Dart | Automático |

**Keymaps:**
- `<leader>F` - Run Flutter app
- `<leader>D` - List Flutter devices
- `<leader>Q` - Quit Flutter app
- `<leader>R` - Hot reload
- `<leader>H` - Hot restart

**Características:**
- Ejecutar aplicaciones Flutter
- Listar dispositivos disponibles
- Hot reload/restart
- Depuración de código Dart

### 🐛 **Debugger** - `debugger.lua` (Temporalmente Desactivado)

| Característica | Descripción |
| --- | --- |
| **nvim-dap** | Debugger Adapter Protocol |
| **nvim-dap-ui** | UI para el debugger |
| **dap-virtual-text** | Valores de variables en línea |
| **telescope-dap** | Búsqueda en el debugger |

**Keymaps** (cuando activado):
- `F5` - Start/Continue debugging
- `F10` - Step over
- `F11` - Step into
- `F12` - Step out
- `<leader>b` - Toggle breakpoint

### 🔬 **Data Science** - `data-science.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **jupytext.nvim** | Conversión Jupyter <-> Markdown | Automático |
| **vim-csv** | Visualizador de archivos CSV | Automático |

**Características:**
- Soporte para notebooks Jupyter
- Visualización de archivos CSV
- Pandas syntax highlighting

### ✅ **Testing** - `testing.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **vim-test** | Test runner universal | `<leader>tn`, `<leader>tf` |
| **nvim-neotest** | Test runner multi-lenguaje | Integrado |

**Keymaps:**
- `<leader>tn` - Test nearest
- `<leader>tf` - Test file
- `<leader>ts` - Test suite
- `<leader>tv` - Test visit
- `<leader>tg` - Test go

**Características:**
- Soporte para múltiples lenguajes (Python, JS/TS, Ruby, Rust, Go)
- Integración con PyTest, Jest, RSpec
- Visualización de resultados de tests

### 🔀 **Git Avanzado** - `git-advanced.lua`

| Plugin | Descripción | Comando |
| --- | --- | --- |
| **git-conflict.nvim** | Resolver conflictos Git | `<leader>gco`, `<leader>gct` |
| **blamer.nvim** | Git blame inline | Automático |
| **git-browse** | Abrir repo en navegador | `<leader>go` |

**Keymaps:**
- `<leader>gco` - Choose ours (en conflicto)
- `<leader>gct` - Choose theirs (en conflicto)
- `<leader>gcb` - Choose both (en conflicto)
- `<leader>gcn` / `<leader>gcp` - Next/Prev conflicto
- `<leader>go` - Browse repo en navegador

---

## 🎮 **Guía de Plugins**

### 🔮 **Which-key.nvim - Ayuda Visual**

**¿Qué hace?** Muestra automáticamente un menú visual cuando presiones la tecla `<leader>` (Espacio), mostrando todos los atajos disponibles organizados por categoría.

**Características:**
- Menú visual organizado por categorías
- Descripciones claras para cada comando
- Aparición automática al presionar `<leader>`

**Uso:**
- Presiona `<leader>` y espera un momento
- Aparecerá un menú con todas las opciones disponibles
- Navega con las flechas y presiona Enter para seleccionar

---

### 🔍 **Telescope.nvim - Búsqueda Inteligente**

**¿Qué hace?** Es un buscador potente para encontrar archivos, texto y comandos.

| Comando | Acción | Ejemplo de Uso |
| --- | --- | --- |
| `<leader>ff` | Buscar archivos | Escribe el nombre del archivo que buscas |
| `<leader>fg` | Buscar texto en archivos | Encuentra dónde aparece una palabra en el proyecto |
| `<leader>fb` | Buscar buffers | Navegar entre archivos abiertos |
| `<leader>fh` | Buscar help | Buscar documentación de comandos vim/nvim |

**Flujo de trabajo típico:**
1. Presiona `<leader>ff`
2. Escribe parte del nombre del archivo
3. Usa flechas para seleccionar
4. Presiona Enter para abrir

---

### 🌳 **Neo-tree.nvim - Explorador de Archivos**

**¿Qué hace?** Es el explorador de archivos visual, similar al de VSCode.

| Comando | Acción | Uso |
| --- | --- | --- |
| `<leader>e` | Abrir/cerrar explorador | Principal para ver archivos |
| `a` | Crear archivo/directorio | En el explorador, crea nuevo |
| `d` | Borrar archivo/directorio | Elimina lo seleccionado |
| `r` | Renombrar archivo/directorio | Cambia nombre del archivo |
| `y` | Copiar archivo | Copia a portapapeles |
| `x` | Cortar archivo | Mueve archivo |
| `p` | Pegar archivo | Pega archivo copiado/cortado |
| `Tab` | Cambiar foco | Alterna entre archivos y contenido |

**Consejo:** Usa `<leader>e` para abrir el explorador y `Tab` para cambiar entre el explorador y el editor.

---

### 🌈 **Tema Matrix - Statick Theme**

**¿Qué hace?** Tema visual profesional inspirado en Matrix con colores optimizados para desarrollo.

**Características:**
- Colores inspirados en Clean Architecture
- Alto contraste para largas sesiones
- Colores semánticos para diferentes elementos del código
- Integración con principios SOLID y Clean Architecture

**Cambios recientes:**
- ✅ Renombrado de `gentleman-matrix.lua` a `matrix.lua`
- ✅ Todos los nombres actualizados a "Statick"
- ✅ Basado en Tokyonight con paleta Matrix personalizada

---

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

---

### 📊 **Quarto.nvim - Documentos Científicos**

**¿Qué hace?** Es el plugin oficial para trabajar con documentos Quarto (.qmd), que combina texto, código y resultados como Jupyter notebooks.

| Comando | Acción | Cuándo usarlo |
| --- | --- | --- |
| `[b` / `]b` | Navegar entre celdas/chunks | Moverse por el notebook |
| `<localleader>rc` | Ejecutar celda actual | Para probar código específico |
| `<localleader>ra` | Ejecutar celda + lo anterior | Para código dependiente |
| `<localleader>rA` | Ejecutar todas las celdas | Para renderizar notebook completo |
| `<localleader>pp` | Iniciar previsualización | Ver resultado del documento |
| `<localleader>ps` | Detener previsualización | Detener servidor de preview |
| `<localleader>qi` | Inspeccionar documento | Ver información del documento |
| `<localleader>qf` | Formatear documento | Aplicar formato Quarto |

**¿Qué es Quarto?**
- **Herramienta de publicación científica** para crear documentos, presentaciones, sitios web
- **Combina Markdown + código ejecutable** (Python, R, Julia, etc.)
- **Similar a Jupyter notebooks** pero en archivos de texto plano
- **Genera múltiples formatos**: HTML, PDF, Word, etc.

**Instalación de Quarto (si no está instalado):**
```bash
# macOS con Homebrew
brew install quarto

# Verificar instalación
quarto --version

# Crear nuevo proyecto Quarto
quarto create my-project

# Iniciar proyecto existente
cd my-project
quarto preview
```

**Flujo de trabajo con Quarto + Neovim:**
1. Crear archivo `.qmd` o abrir proyecto existente
2. Escribir contenido en Markdown con chunks de código
3. Usar `]b`/[b` para navegar entre celdas
4. Ejecutar código con `<localleader>rc`
5. Previsualizar resultados con `<localleader>pp`
6. Renderizar documento final con `quarto render` en terminal

---

### 🌲 **Treesitter - Resaltado de Código**

**¿Qué hace?** Da colores inteligentes al código basado en su estructura, no solo texto.

| Característica | Beneficio |
| --- | --- |
| Resaltado sintáctico preciso | Entiende la estructura del código |
| Navegación de código | Usa ]c y [c para moverse entre funciones |
| Refactorización inteligente | Sabe qué es función, variable, etc. |

**Consejo:** Treesitter funciona automáticamente, solo necesita que los lenguajes estén instalados.

---

### 🔤 **Autopairs - Pares Automáticos**

**¿Qué hace?** Cierra automáticamente paréntesis, llaves, comillas, etc.

| Acción | Resultado |
| --- | --- |
| Escribe `(` | Se convierte en `()` con cursor dentro |
| Escribe `{` | Se convierte en `{}` con cursor dentro |
| Escribe `"` | Se convierte en `""` con cursor dentro |
| Presiona `Backspace` dentro de par | Borra ambos paréntesis |

**Consejo:** Ayuda a escribir código más rápido y evita errores de paréntesis no cerrados.

---

### 💬 **Completions - Autocompletado Inteligente**

**¿Qué hace?** Sugiere palabras y código mientras escribes.

| Comando | Acción |
| --- | --- |
| `Ctrl+Space` | Activar sugerencias |
| `Tab/Enter` | Aceptar sugerencia |
| `Ctrl+n/p` | Navegar entre opciones |
| `Esc` | Cancelar sugerencias |

**Consejo:** Funciona mejor si tienes configurado LSP.

---

### 🔧 **LSP - Servidor de Lenguaje**

**¿Qué hace?** Proporciona inteligencia avanzada del lenguaje que estás usando.

| Característica | Beneficio |
| --- | --- |
| `gd` | Ir a definición de función/variable |
| `gr` | Buscar referencias |
| `K` | Mostrar documentación |
| `[d` / `]d` | Navegar entre diagnósticos |
| `<leader>rn` | Renombrar símbolo |
| `<leader>ca` | Code actions |
| `:LspInfo` | Ver servidores activos |

**Lenguajes configurados:**
- `lua_ls` - Para archivos Lua
- `ts_ls` - Para TypeScript/JavaScript
- `pyright` - Para Python
- `html`, `cssls`, `tailwindcss` - Para desarrollo web

**Consejo:** LSP es lo que transforma Neovim en un IDE completo.

---

### 📝 **Markdown - Renderizado**

**¿Qué hace?** Muestra tus archivos Markdown con formato visual atractivo.

| Comando | Acción |
| --- | --- |
| Abrir archivo .md | Se renderiza automáticamente |
| Editar archivo .md | Alterna entre modo edición y vista previa |

**Consejo:** Ideal para tomar notas o documentar proyectos.

---

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

**Consejo:** Con esto no necesitas salir de Neovim para usar Git.

---

### 🤖 **OpenCode.nvim - Asistente de IA (Desactivado)**

**Estado:** ⚠️ **Desactivado temporalmente**

El plugin OpenCode.nvim ha sido desactivado temporalmente debido a diferencias en la API o incompatibilidad con la versión actual.

**Keymaps desactivados (comentados en keymaps.lua):**
- Clean Architecture (`<leader>ca`, `<leader>cs`, `<leader>cd`, `<leader>ci`)
- SOLID Principles (`<leader>spl`, `<leader>ssr`, `<leader>soc`, `<leader>sli`, `<leader>sii`, `<leader>sdi`)
- Design Patterns (`<leader>pf`, `<leader>pr`, `<leader>po`, `<leader>pst`, `<leader>pa`)
- Testing (`<leader>tb`, `<leader>tc`, `<leader>tu`, `<leader>tcov`)
- Architectural Decisions (`<leader>ad`, `<leader>al`, `<leader>ar`)
- AI Agents (`<leader>as`, `<leader>ao`, `<leader>alb`, `<leader>af`)
- Code Quality (`<leader>qc`, `<leader>qn`, `<leader>qm`)
- Templates (`<leader>td`, `<leader>tp`, `<leader>te`)
- UI (`<leader>osb`, `<leader>oh`, `<leader>oc`)

**Nota:** Estos keymaps se pueden reactivar eliminando los comentarios en `lua/statick/core/keymaps.lua` y cambiando `enabled = false` a `enabled = true` en `lua/statick/plugins/opencode.lua`.

---

## 📊 **Instalación y Configuración de Quarto**

### 📦 **Instalar Quarto**

**Para macOS (usando Homebrew):**
```bash
# Instalar Quarto CLI
brew install --cask quarto

# Verificar instalación
quarto check

# Ver versión
quarto --version
```

**Para otros sistemas:**
```bash
# Linux (apt/apt)
sudo apt-get install quarto

# Windows (usando winget)
winget install Posit.Quarto

# O descargar desde quarto.org
```

### 🛠️ **Configuración Inicial**

```bash
# Crear nuevo proyecto Quarto
quarto create mi-proyecto

# O iniciar en directorio existente
cd mi-proyecto
quarto init

# Estructura del proyecto:
mi-proyecto/
├── index.qmd          # Documento principal
├── _quarto.yml         # Configuración del proyecto
├── styles/             # CSS personalizados
└── output/             # Archivos generados (after render)
```

### ⚙️ **Configuración de Neovim para Quarto**

El plugin `quarto-nvim` ya está configurado en este entorno, pero si quieres instalarlo manualmente:

```bash
# Asegurar que Quarto está en PATH
echo 'export PATH="$PATH:/Applications/Quarto.app/bin"' >> ~/.zshrc
source ~/.zshrc

# Verificar que Neovim reconoce archivos Quarto
nvim --headless -c "autocmd Filetype quarto echo 'Quarto detected'" -c "q"
```

### 🚀 **Flujo de Trabajo Completo**

1. **Abrir proyecto Quarto:**
   ```bash
   cd mi-proyecto
   nvim index.qmd
   ```

2. **Escribir contenido** con chunks de código:
   - Texto normal en Markdown
   - Código con ````{python}`` o ````{r}`
   - Opciones de chunk con `#|`

3. **Ejecutar código:**
   - `]b/[b` para navegar entre celdas
   - `<localleader>rc` para ejecutar celda actual
   - `<localleader>rA` para ejecutar todo

4. **Previsualizar en tiempo real:**
   ```bash
   # En terminal (dentro de nvim con :term)
   quarto preview

   # O usar atajo en nvim:
   <localleader>pp
   ```

5. **Renderizar documento final:**
   ```bash
   # Renderizar a HTML (por defecto)
   quarto render

   # Renderizar a PDF
   quarto render --to pdf

   # Renderizar todos los formatos
   quarto render --all
   ```

### 🎯 **Formatos de Salida**

**Comandos de renderizado:**
```bash
quarto render --to html          # Página web
quarto render --to pdf           # Documento PDF
quarto render --to docx          # Microsoft Word
quarto render --to revealjs      # Presentación HTML
quarto render --to github        # Documentos para GitHub
quarto render --to typst         # Usando Typst para PDF
```

### 🔧 **Configuración Avanzada**

**Archivo `_quarto.yml`:**
```yaml
project:
  type: default
  output-dir: _output

format:
  html:
    theme: cosmo
    toc: true
    code-fold: true

  pdf:
    documentclass: article
    margin-left: 2cm

  revealjs:
    theme: solarized
    transition: slide
```

### 💡 **Consejos Productivos**

1. **Chunks atómicos:** Un chunk = una idea/tarea
2. **Nombres descriptivos:** Usa `#| label: grafico-ventas`
3. **Prueba incremental:** Ejecuta celdas individualmente
4. **Documenta resultados:** Usa chunks de texto para explicar
5. **Version control:** Git tracking de archivos .qmd

---

## 📂 **Estructura del Proyecto**

La configuración adopta una arquitectura modular. El punto de entrada `init.lua` delega la carga a módulos específicos ubicados en el directorio `lua/statick/`, asegurando una separación clara entre la configuración base y las extensiones.

A continuación se detalla la estructura exacta del sistema de archivos:

```
~/.config/nvim/
├── init.lua                    # Punto de entrada principal: inicializa Lazy.nvim y carga módulos.
├── lazy-lock.json              # Instantánea de versiones exactas de los plugins (garantiza reproducibilidad).
├── Readme.md                   # Documentación del proyecto.
└── lua/
    └── statick/                # Namespace principal del usuario.
        ├── core/               # Configuraciones fundamentales de Neovim.
        │   ├── options.lua     # Opciones generales (vim.opt).
        │   └── keymaps.lua     # 🆕 Todos los mapeos de teclado centralizados.
        └── plugins/            # Especificaciones modulares de cada plugin.
            ├── autopairs.lua
            ├── colorscheme.lua
            ├── completions.lua
            ├── git.lua
            ├── help.lua        # 🆕 Which-key.nvim - Menú visual de atajos.
            ├── lsp.lua         # Configuración crítica de Mason y lspconfig.
            ├── markdown.lua
            ├── matrix.lua       # 🆕 Renombrado de gentleman-matrix.lua
            ├── neotree.lua
            ├── opencode.lua     # Asistente de IA (desactivado temporalmente).
            ├── quarto.lua       # Integración para documentos científicos Quarto.
            ├── telescope.lua
            ├── tmux.lua        # Integración con tmux para terminal workflow.
            └── treesitter.lua
```

*Estructura visual basada en la implementación actual.*

### 🔄 **Cambios Recientes**

**Actualización v2.0 - Arquitectura Mejorada:**

- ✅ **Keymaps centralizados**: Todos los keymaps ahora están en `lua/statick/core/keymaps.lua`
- ✅ **Ayuda visual agregada**: `which-key.nvim` muestra menú de atajos al presionar `<leader>`
- ✅ **Tema renombrado**: `matrix.lua` (antes `gentleman-matrix.lua`)
- ✅ **Nombres actualizados**: Todos los nombres cambiados de "Diego" a "Statick"
- ✅ **Plugin IA desactivado**: `opencode.nvim` desactivado temporalmente por incompatibilidad de API
- ✅ **Lazy loading implementado**: Keymaps de Quarto y Gitsigns cargados solo cuando es necesario
- ✅ **Documentación mejorada**: README.md actualizado con todos los cambios

---

## 🚀 **Instalación y Requisitos**

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

## 📋 **Principios de Diseño**

* **Transparencia:** Cada plugin tiene su propio archivo de configuración aislado, lo que facilita la auditoría y el ajuste fino sin afectar otras partes del sistema.
* **Precisión Técnica:** La configuración de LSP está ajustada para proporcionar diagnósticos y autocompletado precisos para el stack definido (Lua, Web, Python), evitando configuraciones globales ruidosas.
* **Integración Terminal:** Flujo de trabajo optimizado entre Neovim y tmux para desarrollo eficiente con navegación seamless entre splits y panes.
* **Ayuda Visual:** Integración con which-key.nvim para mostrar menú visual de todos los atajos disponibles.
* **Entorno Educativo:** La claridad del código y la estructura modular están pensadas para servir como ejemplo en entornos de enseñanza universitaria.

---

## ⚡ **Quick Start - Comandos Esenciales**

| Categoría | Comando | Acción | Mnemotécnico |
| --- | --- | --- | --- |
| **Ayuda** | `<leader>` | Mostrar menú de atajos | Press leader key |
| **Explorador** | `<leader>e` | Abrir Neo-tree | "E"xplorer |
| **Búsqueda** | `<leader>ff` | Buscar archivos | "Find Files" |
| **Búsqueda** | `<leader>fg` | Buscar texto | "Find Grep" |
| **Búsqueda** | `<leader>fb` | Buscar buffers | "Find Buffers" |
| **Búsqueda** | `<leader>fh` | Buscar ayuda | "Find Help" |
| **Navegación** | `gd` | Ir a definición | "Go to Definition" |
| **Documentación** | `K` | Ver docs | "Keep" (mantener pulsado) |
| **Terminal** | `:term` | Abrir terminal | "Terminal" |
| **Git** | `:Git status` | Ver estado git | "Git" |
| **Quarto** | `<localleader>rc` | Ejecutar celda | "Run Cell" |
| **Quarto** | `<localleader>pp` | Previsualizar | "Preview" |
| **Tmux** | `Ctrl+h/j/k/l` | Navegar paneles | Navegación en 4 direcciones |

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

### ❓ **"El tema no se aplica correctamente"**
```bash
# Verificar que el tema está cargado
:colorscheme

# Si muestra error, verificar archivo matrix.lua
:lua print(vim.inspect(package.loaded))
```

### ❓ **"Which-key no aparece"**
```bash
# Verificar que el plugin está instalado
:Lazy

# Presiona <leader> y espera 1 segundo
# Si no aparece, verificar configuración en help.lua
```

### ❓ **"Quarto keymaps no funcionan"**
```bash
# Los keymaps de Quarto solo se cargan al abrir archivos .qmd
# Abrir un archivo Quarto y verificar:
:echo exists("*quarto#runner#run_cell")

# Si devuelve 0, el plugin no está cargado correctamente
```

---

## 💡 **Consejos para Máxima Productividad**

1. **Configura tu leader key**: `<leader>` es `Espacio` por defecto
2. **Usa which-key frecuentemente**: Presiona `<leader>` para ver todos los comandos disponibles
3. **Usa `<leader>ff` frecuentemente**: Es más rápido que navegar manualmente
4. **Aprovecha la navegación tmux**: Muevete entre nvim y tmux sin cambiar atajos
5. **Mantén tmux abierto**: Un solo terminal con múltiples ventanas
6. **Usa Git integrado**: No salgas de nvim para hacer commits
7. **Personaliza gradualmente**: Añade tus propios atajos con el tiempo
8. **Practica los comandos básicos**: La velocidad viene con la práctica
9. **Usa Quarto para documentación**: Combina código y documentación en archivos .qmd
10. **Explora which-key**: Descubre nuevas funcionalidades presionando `<leader>`

---

## 📚 **Recursos Adicionales**

- **Documentación oficial Neovim**: `:help`
- **Vimtutor**: Ejecuta `vimtutor` en terminal
- **Guía de comandos LSP**: `:help lsp`
- **Documentación Telescope**: `:help telescope`
- **Guía Treesitter**: `:help treesitter`
- **Documentación Quarto**: https://quarto.org/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **Which-key.nvim**: https://github.com/folke/which-key.nvim

---

## 🔄 **Historial de Cambios**

### v2.0 - Diciembre 2024
- Arquitectura modular mejorada
- Keymaps centralizados en `core/keymaps.lua`
- Integración de which-key.nvim
- Tema renombrado a Matrix
- Todos los nombres actualizados a Statick
- OpenCode.nvim desactivado temporalmente
- Documentación mejorada y expandida

### v1.0 - Versión inicial
- Configuración base de Neovim
- Plugins esenciales instalados
- Integración con Quarto
- Tema personalizado

---

## 📝 **Notas del Autor**

Esta configuración ha sido diseñada para ser modular, mantenible y educativa. Cada archivo tiene un propósito claro y está documentado para facilitar el aprendizaje y la personalización.

Para cualquier pregunta o sugerencia, por favor abra un issue en el repositorio.

**Statick Medardo Saavedra García** - 2024
