# Dotfiles

Este repositorio contiene mi configuración personal para diversas herramientas y programas en mi entorno de desarrollo, con un enfoque en Neovim, Oh My Zsh, Hypr, y Kitty.

## Herramientas Configuradas

### 1. **Neovim**

Neovim es mi editor de texto principal. Esta configuración incluye:

- **Plugins**: Usamos un gestor de plugins como `vim-plug` para instalar y gestionar plugins esenciales, como autocompletado, navegación de archivos, y más.
- **Configuración personalizada**: Se encuentra en el archivo `init.vim` (o `init.lua` si prefieres usar Lua para configurar Neovim).
- **Atajos de teclado**: He configurado una serie de atajos de teclado para mejorar la eficiencia y la experiencia de uso.

#### Cómo usar:

1. Clona el repositorio de dotfiles:

   ```bash
   git clone https://github.com/tu_usuario/dotfiles.git ~/.dotfiles
   ```

   Crea un enlace simbólico de init.vim (o init.lua) en el directorio de configuración de Neovim:

```bash
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
```

#### Instala los plugins necesarios:

Abre Neovim y ejecuta :PlugInstall (si usas vim-plug).

2. Oh My Zsh

Oh My Zsh es mi framework de gestión de configuraciones para el shell Zsh. Las configuraciones incluyen:

**Temas personalizados**: El tema agnoster es el predeterminado, pero puedes modificarlo según tus preferencias.

**Plugins**: Tengo habilitados varios plugins útiles, como zsh-autosuggestions, zsh-syntax-highlighting, y más.

**Alias y funciones personalizadas**: Se incluyen alias para mejorar la productividad en el terminal.

#### Cómo usar:

Si no tienes Zsh o Oh My Zsh, instala Zsh y Oh My Zsh:

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Clona este repositorio y configura el archivo .zshrc:

```bash
git clone https://github.com/tu_usuario/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

Cambia el shell predeterminado a Zsh:

```bash
chsh -s $(which zsh)
```

Reinicia tu terminal y disfruta de la configuración de Zsh.

3. Hypr

Hypr es un gestor de ventanas dinámico (Wayland) que utilizo para mi entorno de escritorio. Algunas de las configuraciones incluyen:

- Atajos de teclado para la navegación entre ventanas y la gestión de pantallas.
- Estilo visual con temas personalizados.
- Autostart de aplicaciones esenciales al iniciar.

#### Cómo usar:

Instala Hypr y sus dependencias. En Fedora, puedes hacerlo con:

```bash
sudo dnf install hyprland
```

Clona este repositorio y configura el archivo de configuración de Hypr:

```bash
git clone https://github.com/tu_usuario/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/hypr/config ~/.config/hypr/config
```

Reinicia el entorno o recarga Hypr para aplicar la configuración.

4. Kitty

Kitty es mi emulador de terminal principal, y está configurado para ser rápido, ligero y visualmente atractivo. Algunas de las configuraciones incluyen:

**Temas de colores**: Se utiliza un esquema de colores oscuro con resaltado de sintaxis.
**Fuentes**: Configurado para usar fuentes de la familia FiraCode con ligaduras.

Tamaño y comportamiento del terminal: Ajustes para el tamaño de la ventana y la apariencia de los elementos en el terminal.

#### Cómo usar:

Instala Kitty:

```bash
sudo apt install kitty
```

Clona este repositorio y configura el archivo de configuración de Kitty:

```bash
git clone https://github.com/tu_usuario/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

```
Reinicia Kitty o abre una nueva instancia para ver los cambios.

# Instalación General

Clona este repositorio:

```

```bash
git clone https://github.com/statick88/dotfiles.git ~/home/$USER/
```

Instala los archivos de configuración según lo explicado en las secciones anteriores para Neovim, Zsh, Hypr y Kitty.

¡Listo! Disfruta de tu entorno de desarrollo personalizado.

# Personalización

Cada herramienta mencionada (Neovim, Zsh, Hypr, Kitty) tiene su propia configuración que puedes personalizar:

**Neovim**: Personaliza el archivo ~/.config/nvim/init.vim o init.lua.
**Oh My Zsh**: Modifica el archivo ~/.zshrc para añadir alias o plugins.
**Hypr**: Modifica el archivo de configuración ~/.config/hypr/config para adaptar los atajos de teclado y la configuración de ventanas.
**Kitty**: Cambia el archivo ~/.config/kitty/kitty.conf para ajustar el esquema de colores, las fuentes, y el tamaño de la ventana.

# Recursos adicionales

- Neovim
- Oh My Zsh
- Hypr
- Kitty

# Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
