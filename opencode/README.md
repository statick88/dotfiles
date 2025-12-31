# 🤖 OpenCode Configuration

Configuración optimizada de OpenCode AI Assistant integrada con el ecosistema de desarrollo estático.

---

## 📋 **Descripción**

OpenCode es un asistente de codificación con IA de código abierto que funciona directamente en la terminal. Esta configuración proporciona:

- 🔌 **Plugin Base**: `@opencode-ai/plugin` (v1.0.212)
- 🛠️ **Herramientas Esenciales**: Lectura, escritura, bash, búsqueda web
- 🔗 **Integración Neovim**: Plugin `opencode.nvim` ya configurado
- ⚙️ **Configuración Modular**: Preparado para extensiones futuras

---

## 🚀 **Instalación y Uso**

### **Prerrequisitos:**
```bash
# OpenCode ya debe estar instalado
opencode --version  # Verificar instalación (actual: 1.0.212)
```

### **Inicio Rápido:**
```bash
# Iniciar OpenCode en cualquier proyecto
opencode

# Con directorio específico
opencode /ruta/a/tu/proyecto
```

---

## 🔧 **Configuración Actual**

### **Estructura de Archivos:**
```
~/.config/opencode/
├── README.md                    # Este archivo
├── package.json                 # Dependencias del plugin
├── bun.lock                     # Lockfile de dependencias
├── node_modules/               # Módulos instalados
└── .gitignore                  # Archivos ignorados
```

### **Plugin Instalado:**
- **@opencode-ai/plugin**: Plugin base para extensiones personalizadas
- **Versión**: 1.0.212
- **Capacidades**: Hooks personalizados, herramientas definibles, eventos

---

## 🎯 **Integración con Ecosistema**

### **Neovim Integration:**
- 📍 **Plugin**: `opencode.nvim` configurado en `nvim/lua/statick/plugins/opencode.lua`
- 🎮 **Comandos**: `:OpenCodeAsk`, `:OpenCodeSelect`, `:OpenCodePrompt`
- 🔄 **Sincronización**: Configuración compartida entre terminal y editor

### **Flujo de Trabajo:**
1. **Terminal**: Usar `opencode` para tareas completas de desarrollo
2. **Neovim**: Usar plugin para asistencia dentro del editor
3. **Proyectos**: Configuración automática por proyecto con `.opencode/`

---

## 🚀 **Próximos Pasos y Mejoras**

### **Plan de Mejoras Futuras:**

#### **🔌 Extensiones Sugeridas:**
1. **oh-my-opencode**: Agentes especializados y herramientas avanzadas
2. **opencode-skills**: Gestión de capacidades y prompts
3. **opencode-type-inject**: Inyección automática de tipos TypeScript

#### **🤖 Agentes Especializados:**
- **Sisyphus**: Orquestador de tareas con pensamiento extendido
- **Oracle**: Análisis de arquitectura y revisión de código
- **Librarian**: Búsqueda de documentación y ejemplos
- **Frontend Engineer**: Especialista en UI/UX

#### **🛠️ Herramientas Avanzadas:**
- **LSP Integration**: Refactorización y análisis de código
- **AST Tools**: Búsqueda y reemplazo aware de sintaxis
- **Session Management**: Historial y continuidad de sesiones

---

## 📚 **Documentación Adicional**

- 📖 **[Documentación Oficial de OpenCode](https://opencode.ai/docs/)**
- 🚀 **[Oh My OpenCode](https://github.com/code-yeongyu/oh-my-opencode)** - Extensiones avanzadas
- 🔌 **[Ecosistema de Plugins](https://opencode.ai/docs/ecosystem/)**

---

## 🔗 **Integración con Dotfiles**

Esta configuración es parte del ecosistema más grande de dotfiles:

- 🎯 **[README Principal](../README.md)** - Configuración completa del entorno
- 💻 **[Neovim Config](../nvim/Readme.md)** - Editor principal con OpenCode integrado
- 🐱 **[Kitty Config](../kitty/README.md)** - Terminal moderna

---

*Esta configuración está diseñada para crecer con las necesidades del desarrollo moderno, manteniendo simplicidad al inicio pero permitiendo expansiones poderosas.*