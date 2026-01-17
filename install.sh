#!/bin/bash
set -e

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "🚀 Iniciando instalación de Dotfiles de Sergio..."

# --- 📦 INSTALACIÓN DE PAQUETES ---
echo "📦 Actualizando sistema e instalando dependencias..."
sudo apt update && sudo apt install -y \
    git curl tmux neovim build-essential nano unzip \
    ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide

# Yazi (Terminal File Manager)
if ! command -v yazi &> /dev/null; then
    echo "📥 Instalando Yazi desde GitHub (.deb)..."
    YAZI_DEB=$(curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | grep "browser_download_url.*x86_64-unknown-linux-gnu.deb" | cut -d : -f 2,3 | tr -d \" | xargs)
    curl -L -o /tmp/yazi.deb $YAZI_DEB
    sudo apt install -y /tmp/yazi.deb
    rm /tmp/yazi.deb
fi

# --- 🛠️ CONFIGURACIÓN DE HERRAMIENTAS ---

# Tmux Plugin Manager (TPM)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "📥 Instalando Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Crear carpetas necesarias
mkdir -p ~/.config/yazi
mkdir -p ~/.config/nvim

# --- 🔗 ENLACES SIMBÓLICOS ---
echo "🔗 Creando enlaces simbólicos..."

ln_sf() {
    local src=$1
    local dest=$2
    if [ -L "$dest" ] || [ -e "$dest" ]; then
        echo "⚠️ $dest ya existe, omitiendo..."
    else
        ln -sf "$src" "$dest"
        echo "✅ Enlazado: $dest"
    fi
}

ln_sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln_sf "$DOTFILES_DIR/tmux_csheet.md" ~/tmux_csheet.md
ln_sf "$DOTFILES_DIR/yazi/yazi.toml" ~/.config/yazi/yazi.toml
ln_sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua

# --- 🏠 CONFIGURACIÓN BASH ---
echo "🏠 Configurando .bashrc..."
# Evitamos duplicados limpiando antes de añadir
sed -i '/# SERGIO_DOTFILES/,/# END_SERGIO/d' ~/.bashrc

cat << EOF >> ~/.bashrc
# SERGIO_DOTFILES
export EDITOR="nvim"
export DOTFILES_DIR="$DOTFILES_DIR"
source "\$DOTFILES_DIR/bashrc_snippet"
# END_SERGIO
EOF

echo "✅ Todo instalado correctamente."
echo "👉 Ejecuta: source ~/.bashrc"
echo "👉 En tmux, pulsa 'prefix + I' para instalar plugins."

