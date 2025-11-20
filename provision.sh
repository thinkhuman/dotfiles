#!/usr/bin/env bash
set -euo pipefail

echo "==> Starting full provisioning..."

sudo apt update

sudo apt install -y \
    git \
    curl \
    stow \
    tmux \
    eza \
    btop \
    pandoc \
    tealdeer \
    fonts-firacode

if ! command -v codium >/dev/null 2>&1; then
    echo "==> Installing VSCodium..."
    wget -qO- https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/vscodium.gpg
    echo "deb [signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list
    sudo apt update
    sudo apt install -y codium
fi

if ! command -v starship >/dev/null 2>&1; then
    echo "==> Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! command -v alacritty >/dev/null 2>&1; then
    echo "==> Installing Alacritty..."
    sudo apt install -y alacritty
fi

DOTFILES_DIR="${HOME}/dotfiles"

echo
echo "==> Applying dotfiles..."
if [ -f "${DOTFILES_DIR}/bootstrap-dotfiles.sh" ]; then
    bash "${DOTFILES_DIR}/bootstrap-dotfiles.sh"
else
    echo "ERROR: bootstrap-dotfiles.sh not found."
    exit 1
fi

echo
echo "==> Provisioning complete!"
