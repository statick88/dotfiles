# Neovim Configuration Guide - De Principiante a Avanzado

> Esta guía cubre desde los fundamentos básicos (movimiento con hjkl) hasta el uso avanzado de plugins especializados. Todo diseñado para maximizar tu productividad como desarrollador.

**Configuración Base:** [LazyVim](https://www.lazyvim.org/) + [OpenCode.nvim](https://opencode.ai/) + GitHub Copilot

---

## 📑 Tabla de Contenidos

1. [Conceptos Básicos](#conceptos-básicos)
2. [Movimiento y Navegación](#movimiento-y-navegación)
3. [Edición de Texto](#edición-de-texto)
4. [Búsqueda y Reemplazo](#búsqueda-y-reemplazo)
5. [Gestión de Buffers y Ventanas](#gestión-de-buffers-y-ventanas)
6. [Plugins Avanzados](#plugins-avanzados)
7. [AI & Copilot](#ai--copilot)
8. [Git Integration](#git-integration)
9. [Testing & Debugging](#testing--debugging)
10. [Quarto & Notebook Analysis](#quarto--notebook-analysis)
11. [Tips & Tricks](#tips--tricks)

---

## Conceptos Básicos

### ¿Qué es Neovim?

Neovim es un editor de texto ultra-rápido y altamente configurable. Su principal ventaja: **Vim motions** (atajos de teclado que aumentan tu velocidad de edición exponencialmente).

### Modos en Vim

Vim tiene varios modos:

| Modo | Acceso | Propósito |
|------|--------|----------|
| **Normal** | `Esc` | Navegación y comandos |
| **Insert** | `i`, `I`, `a`, `A` | Escribir código |
| **Visual** | `v`, `V`, `Ctrl-v` | Seleccionar texto |
| **Command** | `:` | Ejecutar comandos |
| **Terminal** | `:term` o `Ctrl-\` | Terminal integrada |

**Pro Tip:** Siempre que no estés escribiendo activamente, presiona `Esc` para volver a Normal mode.

---

## Movimiento y Navegación

### Los 4 Movimientos Básicos (hjkl)

La base de Vim: moverte sin usar las flechas del teclado.

```
        k (arriba)
        |
h (izq) - j (abajo)
```

**Uso Básico:**
```vim
h       " Mover 1 carácter a la izquierda
j       " Mover 1 línea abajo
k       " Mover 1 línea arriba
l       " Mover 1 carácter a la derecha
```

**Con Multiplicadores:**
```vim
5h      " Mover 5 caracteres a la izquierda
10j     " Mover 10 líneas abajo
3k      " Mover 3 líneas arriba
```

### Movimientos Avanzados por Palabras

```vim
w       " Ir al inicio de la siguiente palabra
e       " Ir al final de la palabra actual
b       " Ir al inicio de la palabra anterior
W       " Ir al inicio de la siguiente PALABRA (separada por espacios)
E       " Ir al final de la siguiente PALABRA
B       " Ir al inicio de la PALABRA anterior
```

**Diferencia w vs W:**
- `w`: Separa por puntuación y espacios
- `W`: Solo separa por espacios

### Movimientos de Línea

```vim
0       " Ir al inicio de la línea
^       " Ir al primer carácter no-blanco
$       " Ir al final de la línea
g_      " Ir al último carácter no-blanco
```

### Movimientos Globales

```vim
gg      " Ir al inicio del archivo
G       " Ir al final del archivo
100G    " Ir a la línea 100
Ctrl-u  " Subir media pantalla
Ctrl-d  " Bajar media pantalla
Ctrl-b  " Subir una pantalla completa
Ctrl-f  " Bajar una pantalla completa
%       " Ir al paréntesis, llave o corchete coincidente
```

### Búsqueda Rápida (Flash.nvim)

**Este plugin te permite saltar a cualquier lugar en 2-3 teclas:**

```vim
s       " Activar Flash search
        " Escribe 2 caracteres para encontrar
        " Presiona la letra sugerida para saltar
```

**Ejemplo:** Para ir a `console.log`:
1. Presiona `s`
2. Escribe `co`
3. Flash muestra todas las coincidencias con letras
4. Presiona la letra para saltar

```vim
S       " Flash con Treesitter (búsqueda sintáctica)
```

---

## Edición de Texto

### Insertar Texto

```vim
i       " Insertar antes del cursor
I       " Insertar al inicio de la línea
a       " Insertar después del cursor
A       " Insertar al final de la línea
o       " Nueva línea debajo e insertar
O       " Nueva línea arriba e insertar
```

**Salir de Insert:** Presiona `Esc`

### Eliminar (Delete)

```vim
x       " Eliminar carácter bajo el cursor
X       " Eliminar carácter anterior
d       " Delete (requiere movimiento)
dd      " Eliminar línea completa
dw      " Eliminar palabra
d$      " Eliminar hasta fin de línea
d0      " Eliminar desde inicio de línea
```

**Combinaciones útiles:**
```vim
5dd     " Eliminar 5 líneas
d5j     " Eliminar hasta 5 líneas abajo
dip    " Eliminar párrafo completo
```

### Cambiar (Change)

`c` = delete + insert automático

```vim
c       " Cambiar (como delete pero entra en insert)
cc      " Cambiar línea completa
cw      " Cambiar palabra
c$      " Cambiar hasta fin de línea
ci"     " Cambiar contenido dentro de comillas
```

**Ejemplo:**
```vim
" Posición: console.log
ci"     " Entra en insert entre las comillas
```

### Copiar y Pegar

```vim
y       " Copiar (yank) con movimiento
yy      " Copiar línea
yw      " Copiar palabra
y$      " Copiar hasta fin de línea
p       " Pegar después del cursor
P       " Pegar antes del cursor
```

**Con Visual:**
```vim
v       " Seleccionar (visual character)
V       " Seleccionar líneas completas
Ctrl-v  " Seleccionar bloque
y       " Copiar selección
d       " Cortar selección
```

### Undo / Redo

```vim
u       " Deshacer (undo)
Ctrl-r  " Rehacer (redo)
```

---

## Búsqueda y Reemplazo

### Búsqueda Básica

```vim
/pattern    " Buscar hacia adelante
?pattern    " Buscar hacia atrás
n           " Siguiente coincidencia
N           " Coincidencia anterior
*           " Buscar palabra bajo cursor (adelante)
#           " Buscar palabra bajo cursor (atrás)
```

### Telescope - Búsqueda Potente

**Atajo:** `<leader>ff`

Telescope es un fuzzy finder que te permite buscar archivos, buffers, comandos, etc.

```vim
<leader>ff    " Find Files - Buscar archivos en el proyecto
<leader>fg    " Live Grep - Buscar contenido en archivos
<leader>fb    " Find Buffers - Buscar entre buffers abiertos
<leader>fh    " Help Tags - Buscar en documentación
<leader>fc    " Find Commands - Buscar comandos de Vim
```

**Dentro de Telescope:**
- `Ctrl-c` o `Esc` para salir
- Escribe para filtrar
- `Ctrl-j/k` para navegar
- `Enter` para seleccionar

### Reemplazo

```vim
:s/old/new/         " Reemplazar primera coincidencia en línea
:s/old/new/g        " Reemplazar todas en la línea
:%s/old/new/g       " Reemplazar en todo el archivo
:%s/old/new/gc      " Reemplazar en todo con confirmación
```

**Ejemplo:**
```vim
:%s/console\.log/console\.error/g    " Cambiar todos los console.log a error
```

---

## Gestión de Buffers y Ventanas

### Entender Buffers

Un **buffer** es un archivo abierto en memoria. Múltiples buffers = múltiples archivos.

### Bufferline - Pestaña de Buffers

Ves todas los buffers abiertos en la parte superior:

```vim
<Tab>        " Ir al siguiente buffer
<S-Tab>      " Ir al buffer anterior
<leader>1    " Ir al buffer 1
<leader>2    " Ir al buffer 2
<leader>3    " Ir al buffer 3
<leader>4    " Ir al buffer 4
<leader>5    " Ir al buffer 5
:bd          " Cerrar buffer actual
:bd 2        " Cerrar buffer 2
```

### Ventanas (Splits)

```vim
:sp          " Split horizontal
:vsp         " Split vertical
Ctrl-h       " Mover a ventana izquierda
Ctrl-j       " Mover a ventana abajo
Ctrl-k       " Mover a ventana arriba
Ctrl-l       " Mover a ventana derecha
Ctrl-Left    " Redimensionar ventana (izquierda)
Ctrl-Right   " Redimensionar ventana (derecha)
Ctrl-Up      " Redimensionar ventana (arriba)
Ctrl-Down    " Redimensionar ventana (abajo)
```

### Terminal Integrado

```vim
<C-\>        " Toggle terminal (flotante)
Ctrl-c       " Terminar comando en terminal
exit         " Salir de terminal
```

---

## Plugins Avanzados

### 1. LSP (Language Server Protocol) - Análisis de Código

**¿Qué es?** Soporte de IDE: autocompletado, go-to-definition, refactoring automático.

**Lenguajes Soportados:**
- Lua (`lua_ls`)
- Python (`pyright`)
- TypeScript/JavaScript (`ts_ls`)
- HTML, CSS, JSON, YAML, Bash, Markdown

**Comandos Disponibles:**

```vim
<leader>gd       " Go to Definition - Ir a definición de función
<leader>gr       " Go to References - Ver todas las referencias
<leader>gi       " Go to Implementation - Ir a implementación
<leader>k        " Hover Documentation - Ver documentación
<leader>rn       " Rename - Renombrar símbolo en todo el proyecto
<leader>ca       " Code Action - Acciones automáticas (fix, import)
<leader>e        " Show Diagnostics - Ver errores/warnings
[d               " Previous Diagnostic - Diagnostic anterior
]d               " Next Diagnostic - Siguiente diagnostic
```

**Ejemplo Flujo:**
```vim
" Archivo: utils.js
" Cursor en función: myFunction
<leader>gd       " Salta a la definición en otro archivo
<leader>gr       " Ve dónde se usa esta función
<leader>rn       " Renombra en todo el proyecto automáticamente
<leader>ca       " Sugiere fixes automáticos
```

### 2. Mason - Gestor de LSP

```vim
:Mason           " Abre interfaz gráfica para instalar/actualizar servidores
:MasonInstall pyright typescript-language-server  " Instalar específicos
```

### 3. Treesitter - Sintaxis Mejorada

Proporciona resaltado de sintaxis precisamente usando análisis de árbol.

**Ya está instalado y funcionando automáticamente:**
- Resaltado de sintaxis más preciso
- Indentación automática mejorada
- Soporte para 20+ lenguajes

### 4. Git Integration (Fugitive + Gitsigns)

#### Fugitive - Comandos Git desde Vim

```vim
<leader>gs       " Git Status
<leader>gc       " Git Commit
<leader>gp       " Git Push
<leader>gl       " Git Pull
:G               " Abre interfaz git completa
:G diff          " Ver diff de cambios
:G log           " Ver log de commits
```

#### Gitsigns - Indicadores de Cambios

Muestra `+`, `~`, `_` en margen izquierdo indicando cambios.

```vim
]c               " Ir al siguiente cambio
[c               " Ir al cambio anterior
<leader>hs       " Stage hunk (preparar cambio)
<leader>hr       " Reset hunk (descartar cambio)
<leader>hp       " Preview hunk (ver cambio)
<leader>hb       " Blame line (ver quién hizo cambio)
<leader>hd       " Diff this (ver diff del cambio)
```

### 5. Formateo de Código

```vim
<leader>fm       " Format Buffer - Formatea archivo automáticamente
```

**Formateadores automáticos por lenguaje:**
- Lua: `stylua`
- Python: `black`, `isort`
- JavaScript/TypeScript: `prettier`
- JSON, YAML: `prettier`
- Markdown: `prettier`, `markdownlint-cli2`

### 6. Debugging (DAP - Debug Adapter Protocol)

```vim
<leader>db       " Toggle Breakpoint - Añadir/quitar punto de quiebre
<leader>dc       " Continue - Continuar ejecución
<leader>do       " Step Over - Siguiente línea
<leader>di       " Step Into - Entrar en función
<leader>dO       " Step Out - Salir de función
<leader>dr       " Open REPL - Consola de debugger
<leader>dl       " Run Last - Ejecutar último debug
```

**Para Usar:**
1. Instala adaptador: `:MasonInstall debugpy` (Python)
2. Coloca breakpoint: `<leader>db`
3. Ejecuta debug: `:DapContinue`

### 7. Testing (Neotest)

```vim
<leader>tt       " Run File Tests - Ejecutar todos los tests del archivo
<leader>tn       " Run Nearest Test - Ejecutar test más cercano
<leader>ts       " Toggle Test Summary - Ver resumen de tests
<leader>to       " Show Test Output - Ver salida de tests
```

**Soporta:** Python (pytest), JavaScript/TypeScript (Jest), etc.

### 8. Markdown Preview

```vim
<leader>mp       " Toggle Markdown Preview - Ver markdown en navegador
<leader>ms       " Start Markdown Preview
<leader>mq       " Stop Markdown Preview
<leader>mr       " Toggle Render Markdown - Renderizar en editor
<leader>me       " Enable Render Markdown
<leader>md       " Disable Render Markdown
```

**Render Markdown** renderiza el markdown directamente en Neovim:
- Resalta headers con colores
- Muestra tablas formateadas
- Renderiza código con sintaxis
- Mejora URLs con colores

---

## AI & Copilot

### GitHub Copilot - Autocompletado IA

**En modo Insert (mientras escribes código):**

```vim
<C-j>        " Aceptar sugerencia de Copilot
<C-k>        " Sugerencia anterior
<C-l>        " Siguiente sugerencia
<C-]>        " Descartar sugerencia
```

**Workflow:**
```python
def calculate_
# Copilot sugiere: def calculate_factorial(n):
<C-j>  # Aceptar

# Copilot sugiere todo el cuerpo:
# if n <= 1:
#     return 1
# return n * calculate_factorial(n - 1)
<C-j>  # Aceptar línea
```

### Copilot Chat - Chat IA Avanzado

**Abrir Chat:**
```vim
<leader>cc       " Toggle Copilot Chat
```

**Acciones Predefinidas:**
```vim
<leader>ce       " Explain - Explicar código seleccionado
<leader>cr       " Review - Revisar código para mejoras
<leader>cd       " Fix - Corregir código (en visual mode)
<leader>co       " Optimize - Optimizar código (en visual mode)
```

**Historial y Acciones:**
```vim
<leader>ch       " Chat History - Ver conversaciones anteriores
<leader>cah      " Help Actions - Ver acciones disponibles
<leader>cap      " Prompt Actions - Ver prompts personalizados
```

**Prompts Personalizados Disponibles:**
```
/Explain         " Explicar código
/Review          " Revisar código
/Fix             " Corregir errores
/Optimize        " Optimizar rendimiento
/Docs            " Generar documentación
/Tests           " Generar tests
/LazyVimPlugin   " Analizar plugins LazyVim (personalizado)
/SecurityReview  " Auditar seguridad (personalizado)
/PerformanceAudit" Auditar rendimiento (personalizado)
/BugAnalysis     " Analizar bugs y edge cases (personalizado)
/Refactor        " Refactorizar código (personalizado)
/TypeScript      " Verificar tipos TypeScript (personalizado)
```

**Integración LSP:**
```vim
<leader>cld      " Fix Diagnostics - Usar Copilot para fijar errores LSP
<leader>clr      " Review with Context - Revisar con contexto LSP
```

**Ejemplo Workflow Chat:**

```
# Seleccionar código con v
# Presionar <leader>cr
# En el chat, escribir preguntas adicionales:

> ¿Hay optimizaciones posibles?
> ¿Es seguro este código?
> ¿Hay mejor forma de hacer esto?

# Copilot responde contextualizadamente
```

### OpenCode - AI Assistant Avanzado

**Integración Profunda con Neovim:**

```vim
<leader>oa       " OpenCode: Ask - Pregunta IA con contexto
<leader>os       " OpenCode: Select Action - Menú de acciones
<leader>ot       " OpenCode: Toggle - Activar/desactivar OpenCode
<leader>or       " OpenCode: Add Range - Añadir rango a prompt
<leader>ol       " OpenCode: Add Line - Añadir línea actual
```

**Acciones Rápidas:**
```vim
<leader>oe       " OpenCode: Explain Code - Explicar
<leader>of       " OpenCode: Fix Diagnostics - Fijar errores
<leader>ov       " OpenCode: Review Code - Revisar
<leader>od       " OpenCode: Add Documentation - Documentar
<leader>op       " OpenCode: Add Tests - Hacer tests
<leader>ou       " OpenCode: Scroll Up - Desplazar arriba
<leader>oj       " OpenCode: Scroll Down - Desplazar abajo
```

**Cambiar Modelo IA:**
```vim
<C-a>        " Claude 3.5 Sonnet (modelo principal, potente y rápido)
<C-h>        " Claude 3.5 Haiku (rápido y eficiente)
<C-o>        " Claude 3 Opus (análisis profundo, más lento)
<leader>am   " Menú de modelos - Seleccionar modelo
<leader>as   " Estado AI - Ver modelo actual y métricas
```

**Comandos de Actividad:**
```
:AITeaching        " Modo enseñanza - Usa Sonnet
:AIDevelopment     " Modo desarrollo - Usa Sonnet
:AIContent         " Modo creación contenido - Usa Sonnet
:AIDevOps          " Modo DevOps - Usa Sonnet
:AIDeepAnalysis    " Análisis profundo - Usa Opus
```

---

## Git Integration

### Workflow Completo con Git

**Ver Estado:**
```vim
<leader>gs       " Git Status
```

**Commit Interactivo:**
```vim
<leader>hs       " Stage hunk (cambio individual)
<leader>hr       " Reset hunk (descartar cambio)
:G commit        " Escribir mensaje de commit
```

**Ver Cambios:**
```vim
<leader>hd       " Diff this - Ver cambio específico
<leader>hD       " Diff against last - Comparar con último commit
[c               " Ir a cambio anterior
]c               " Ir a siguiente cambio
```

**Push/Pull:**
```vim
<leader>gp       " Git Push
<leader>gl       " Git Pull
```

**Blame (Ver quién cambió qué):**
```vim
<leader>hb       " Git Blame - Ver quién hizo este cambio
```

---

## Testing & Debugging

### Testing con Neotest

**Estructura Típica:**

```vim
" Archivo: test_utils.py
def test_calculate():
    assert calculate(5) == 120

" Cursor en la prueba
<leader>tn       " Ejecuta solo este test
<leader>tt       " Ejecuta todos los tests del archivo
<leader>ts       " Ver resumen de tests
<leader>to       " Ver salida detallada
```

### Debugging Paso a Paso

**Configuración:**
```vim
:MasonInstall debugpy  " Para Python
```

**Usar:**
```vim
<leader>db       " Coloca breakpoint (aparece punto rojo)
:DapContinue     " Ejecuta hasta breakpoint
<leader>dc       " Continuar ejecución
<leader>do       " Siguiente línea (step over)
<leader>di       " Entrar en función (step into)
<leader>dO       " Salir de función (step out)
```

**Inspeccionar Variables:**
```vim
<leader>dr       " Abre REPL para inspeccionar
# En REPL:
variable_name    " Ver valor
print(x)         " Evaluar expresiones
```

---

## Quarto & Notebook Analysis

### ¿Qué es Quarto?

Quarto es un sistema de publicación científico abierto que permite crear documentos dinámicos con código ejecutable integrado. Perfecto para análisis de datos, reportes científicos y documentación interactiva.

**Soporte en Neovim:**
- **quarto-nvim** - Integración completa con Quarto para renderizado y ejecución
- **otter.nvim** - Soporte para múltiples lenguajes embebidos
- **image.nvim** - Visualización de gráficos y salida

### Archivos Soportados

```vim
*.qmd              " Archivos Quarto Markdown (principal)
*.md               " Markdown con código embebido
*.ipynb            " Jupyter notebooks (con conversión)
```

### Comandos Principales de Quarto

```vim
<leader>qp         " Preview document - Vista previa del documento renderizado
<leader>qc         " Run code cell - Ejecutar celda actual
<leader>qa         " Run all code cells - Ejecutar todos los chunks
```

### Otter - Soporte de Múltiples Lenguajes

Otter mejora el soporte de autocomplete e LSP en código embebido dentro de archivos Quarto:

```vim
<leader>oo         " Otter: Enable language support - Activar features LSP en código
<leader>od         " Otter: Disable language support - Desactivar
<leader>og         " Otter: Ask hover - Información sobre símbolo
```

### Flujo de Trabajo Típico con Quarto

**1. Crear documento:**
```bash
touch analysis.qmd
```

**2. Estructura básica:**
```markdown
---
title: "Mi Análisis"
format: html
engine: python  # o: r, julia, bash, lua
---

## Introducción

Este es un documento Quarto con código ejecutable.

```{python}
# El código aquí se ejecutará
import pandas as pd
data = pd.read_csv("data.csv")
print(data.head())
```
```

**3. En Neovim:**
```vim
" Editar el archivo
nvim analysis.qmd

" Renderizar el documento completo
<leader>qp              " Preview/Renderizar a HTML
" El navegador abre automáticamente

" O ejecutar celdas individuales
<leader>qc              " Ejecutar celda actual
```

### Lenguajes Soportados

Quarto soporta múltiples lenguajes de programación:

| Lenguaje | Engine | Requisitos |
|----------|--------|-----------|
| **Python** | Jupyter | `pip install jupyter` |
| **R** | Knitr | `R` instalado |
| **Julia** | Julia | Julia instalado |
| **Bash** | Bash | Bash shell |
| **Lua** | Lua | Lua instalado |

### Características

**Visualización en tiempo real:**
- Renderizado de HTML/PDF directamente
- Vista previa en navegador
- Integración con LSP para código embebido
- Soporte de gráficos interactivos

**Ejemplo con Python:**
```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 2*np.pi, 100)
y = np.sin(x)
plt.plot(x, y)
plt.show()
```

### Tips & Trucos

**1. Preview incremental:**
```vim
" Quarto renderiza cambios automáticamente
" Abre HTML en navegador con auto-refresh
<leader>qp             " Preview documento
```

**2. Generar reportes profesionales:**
```markdown
---
title: "Reporte de Análisis"
author: "Tu Nombre"
date: today
format: 
  html:
    toc: true
    code-fold: true
---
```

**3. Compartir análisis:**
```vim
" Los documentos .qmd pueden compartirse directamente
" Otros pueden renderizarlos con: quarto render analysis.qmd
```

### Instalación de Requisitos

Si necesitas usar Python:
```bash
pip install jupyter ipython
```

Si necesitas usar R:
```bash
# En R
install.packages("rmarkdown")
```

---

### 1. Which-Key - Descubre Atajos

Presiona `<leader>` y espera:

```vim
<leader>      " Se abre menú mostrando todas las opciones disponibles
```

También funciona:
```vim
<leader>c?   " Ver todas las opciones de Copilot
<leader>g?   " Ver todas las opciones de Git
<leader>t?   " Ver todas las opciones de Testing
```

### 2. Marks - Bookmarks de Neovim

```vim
ma           " Marcar posición como 'a'
mb           " Marcar posición como 'b'
`a           " Ir a marca 'a'
'a           " Ir a línea de marca 'a'
:marks       " Ver todas las marcas
```

**Uso práctico:**
```vim
" En función importante
ma
" Ir a otro archivo
" Trabajar...
`a           " Volver a la marca
```

### 3. Macros - Grabar y Repetir Acciones

```vim
qa           " Empezar a grabar macro en 'a'
" (hacer acciones: iHola<Esc>, etc)
q            " Parar de grabar
@a           " Ejecutar macro 'a' una vez
5@a          " Ejecutar macro 5 veces
@@           " Ejecutar última macro
```

**Ejemplo:** Convertir JSON a CSV
```vim
qa
I{<Esc>        " Añadir { al inicio
A}<Esc>        " Añadir } al final
j              " Ir línea siguiente
q              " Parar

100@a          " Aplicar a 100 líneas
```

### 4. Text Objects - Seleccionar Inteligentemente

```vim
di"       " Delete inside quotes - Borra contenido entre comillas
da"       " Delete around quotes - Borra comillas también
ci(       " Change inside parentheses
yaw       " Yank a word
dip       " Delete inside paragraph
vit       " Select inside tags HTML
```

**Combinaciones:**
```vim
" Cursor en función myFunction()
va(       " Selecciona todo dentro de ()
vap       " Selecciona parámetros
d2i(      " Borra 2 niveles de paréntesis
```

### 5. Registers - Copiar/Pegar Múltiple

```vim
"ayy      " Copiar línea en registro 'a'
"ap       " Pegar de registro 'a'
:reg      " Ver todos los registros
```

**Sistema de registros:**
```vim
"0        " Último delete/copy
"1-9      " Deletes anteriores
"a-z      " Registros personalizados
"*        " Clipboard del sistema
"+        " Clipboard del sistema (alternativo)
```

### 6. Sessions - Guardar Estado

```vim
<leader>qs       " Restore Session - Recuperar sesión guardada
<leader>ql       " Restore Last Session - Última sesión
<leader>qd       " Don't Save Current - No guardar actual
```

### 7. Keymaps Útiles Combinados

**Cambiar entrecomillado:**
```vim
" De: variable = "texto"
" A: variable = 'texto'

c'     " Change inside quotes
```

**Agregar debugging:**
```vim
oprint("value=", value)<Esc>    " Nueva línea con print
```

**Ver contexto rápidamente:**
```vim
<leader>k        " Hover documentation - Ver tipo y documentación
```

### 8. Comandos Útiles

```vim
:set number              " Mostrar números de línea
:set relativenumber      " Números relativos (distancia desde cursor)
:colorscheme             " Ver temas disponibles
:e filename             " Abrir archivo
:w                      " Guardar
:q                      " Salir
:q!                     " Salir sin guardar
:wq                     " Guardar y salir
:syntax on/off          " Activar/desactivar syntax highlighting
:set spell              " Verificación ortográfica
```

### 9. Performance Tips

**Archivos Grandes:**
```vim
:set lazyredraw          " Redibuja menos frecuentemente
:syntax off              " Desactiva resaltado si es muy lento
:set undofile            " Mantiene historial de deshacer
```

**Sesiones Largas:**
```vim
<leader>qs               " Guarda sesión actual
" Cuando cierres y abras Neovim:
<leader>ql               " Recupera última sesión
```

---

## Flujo de Trabajo Recomendado

### Para Desarrollo Frontend (React/Vue)

```vim
<leader>ff                " Abre archivo
<leader>fg                " Busca componente
<leader>cc                " Abre Copilot Chat
" Selecciona código, presiona <leader>cr para revisar
<leader>fm                " Formatea archivo
<leader>tt                " Corre tests
```

### Para Desarrollo Backend (Python/Node)

```vim
<leader>ff                " Abre archivo
<leader>gd                " Ir a definición de función
<leader>gr                " Ver referencias
<leader>ca                " Code actions automáticas
<leader>db                " Añade breakpoint
:DapContinue              " Debug paso a paso
<leader>tn                " Corre test más cercano
```

### Para Documentación (Markdown)

```vim
<leader>mp                " Preview markdown en navegador
<leader>mr                " Renderiza en editor
" Escribe markdown...
<leader>fm                " Formatea automáticamente
:Git add *.md
<leader>gc                " Commit cambios
```

---

## Solución de Problemas

### El editor va lento

**Soluciones:**
```vim
:checkhealth lazyvim      " Ver diagnostics
:set lazyredraw           " Mejora rendering
:syntax off               " Desactiva resaltado
```

### Copilot no funciona

```vim
:checkhealth copilot      " Ver status de Copilot
:CopilotLogin             " Logearse de nuevo
:CopilotLogout            " Salir de sesión
```

### LSP no proporciona autocompletado

```vim
:LspInfo                  " Ver información de LSP activos
:MasonInstall python-lsp-server  " Instalar servidor faltante
```

### Git commands no funcionan

```vim
:G                        " Abre Fugitive status
:messages                 " Ver error messages
```

---

## Recursos Externos

### Documentación Oficial

- **[Neovim Docs](https://neovim.io/doc/)** - Documentación oficial de Neovim
- **[Vim Cheatsheet](https://vim.rtorr.com/)** - Referencia rápida de Vim
- **[LazyVim Docs](https://www.lazyvim.org/)** - Documentación de LazyVim (nuestra base)

### Plugins Documentación

- **[Telescope](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[LSPConfig](https://github.com/neovim/nvim-lspconfig)** - Language servers
- **[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Parsing de sintaxis
- **[CopilotChat](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - Chat de Copilot
- **[Fugitive](https://github.com/tpope/vim-fugitive)** - Git integration
- **[Gitsigns](https://github.com/lewis6991/gitsigns.nvim)** - Git indicators

### AI & Copilot

- **[GitHub Copilot](https://github.com/features/copilot)** - Documentación oficial
- **[OpenCode.ai](https://opencode.ai/)** - Asistente IA avanzado

---

## Estructura de Configuración

```
~/.config/nvim/
├── init.lua                           # Punto de entrada
├── lua/
│   ├── config/
│   │   ├── lazy.lua                   # Bootstrap de Lazy.nvim
│   │   ├── options.lua                # Opciones de Neovim
│   │   ├── keymaps.lua                # Atajos de teclado (incluye Quarto)
│   │   ├── autocmds.lua               # Auto commands
│   │   ├── copilot-prompts.lua        # Prompts personalizados
│   │   └── copilot-lsp-integration.lua # Integración LSP+Copilot
│   └── plugins/
│       ├── ui.lua                     # Tema, bufferline, notificaciones
│       ├── desarrollo.lua             # LSP, formateo, Git, debugging
│       ├── productividad.lua          # Telescope, flash, terminal, markdown
│       ├── quarto.lua                 # Quarto + Molten + Otter + Image
│       ├── copilot.lua                # GitHub Copilot autocompletado
│       ├── copilot-chat.lua           # Chat de Copilot
│       ├── opencode.lua               # OpenCode AI assistant
│       ├── opencode-model-switcher.lua # Cambiar modelos AI
│       └── render-markdown.lua        # Renderizar markdown
├── stylua.toml                        # Configuración de formateador Lua
└── README.md                          # Este archivo
```

---

## Quick Reference - Atajos Más Usados

| Acción | Atajo | Modo |
|--------|-------|------|
| **Navegación** | | |
| Siguiente buffer | `<Tab>` | Normal |
| Buffer anterior | `<S-Tab>` | Normal |
| Buscar archivo | `<leader>ff` | Normal |
| Buscar contenido | `<leader>fg` | Normal |
| **Edición** | | |
| Copiar línea | `yy` | Normal |
| Cambiar línea | `cc` | Normal |
| Eliminar línea | `dd` | Normal |
| Deshacer | `u` | Normal |
| Rehacer | `Ctrl-r` | Normal |
| Formatar buffer | `<leader>fm` | Normal |
| **Copilot** | | |
| Chat Copilot | `<leader>cc` | Normal/Visual |
| Explicar código | `<leader>ce` | Normal/Visual |
| Revisar código | `<leader>cr` | Normal/Visual |
| Copilot Ask | `<leader>oa` | Normal/Visual |
| **Git** | | |
| Git Status | `<leader>gs` | Normal |
| Siguiente cambio | `]c` | Normal |
| Stage hunk | `<leader>hs` | Normal |
| **LSP** | | |
| Ir a definición | `<leader>gd` | Normal |
| Ver referencias | `<leader>gr` | Normal |
| Renombrar | `<leader>rn` | Normal |
| Code action | `<leader>ca` | Normal |
| **Testing** | | |
| Test más cercano | `<leader>tn` | Normal |
| Todos los tests | `<leader>tt` | Normal |
| **Quarto** | | |
| Renderizar documento | `<leader>qp` | Normal |
| Ejecutar celda actual | `<leader>qc` | Normal |
| Ejecutar todos | `<leader>qa` | Normal |
| Otter: Enable | `<leader>oo` | Normal |
| Otter: Disable | `<leader>od` | Normal |

---

## Contacto & Soporte

- **Issues:** [GitHub Issues](https://github.com/anomalyco/opencode)
- **Documentación Oficial:** [OpenCode Docs](https://opencode.ai/docs)
- **Feedback:** Reportar en GitHub

---

## Licencia

Esta configuración está basada en:
- [LazyVim](https://www.lazyvim.org/) - Distribución de Neovim moderna
- Plugins de la comunidad de Neovim

**Última actualización:** Enero 2026

---

**Consejo Final:** Domina hjkl primero, luego aprende movimientos de palabras, y finalmente plugins. La velocidad viene con la práctica. ¡Empieza hoy! 🚀
