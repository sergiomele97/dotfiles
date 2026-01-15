#!/bin/bash
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "🚀 Iniciando instalación de Dotfiles de Sergio..."

# Crear carpetas necesarias
mkdir -p ~/.config/yazi
mkdir -p ~/.config/nvim

# 🔗 ENLACES SIMBÓLICOS
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/tmux_csheet.md" ~/tmux_csheet.md
ln -sf "$DOTFILES_DIR/yazi/yazi.toml" ~/.config/yazi/yazi.toml

# 🏠 CONFIGURACIÓN BASH
# Evitamos duplicados limpiando antes de añadir
sed -i '/# SERGIO_DOTFILES/,/# END_SERGIO/d' ~/.bashrc

cat << EOF >> ~/.bashrc
# SERGIO_DOTFILES
export EDITOR="nvim"
source "$DOTFILES_DIR/bashrc_snippet"
# END_SERGIO
EOF

echo "✅ Todo instalado. Ejecuta: source ~/.bashrc"
