#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/dotfiles"
BACKUP_DIR="${HOME}/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "==> Bootstrapping dotfiles..."
echo "Dotfiles repo: $DOTFILES_DIR"
echo "Backup directory: $BACKUP_DIR"
echo

if ! command -v stow >/dev/null 2>&1; then
    echo "==> Installing GNU Stow..."
    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y stow
    else
        echo "ERROR: No apt found; install stow manually."
        exit 1
    fi
fi

PACKAGES=(
    bash
    git
    tmux
    starship
    alacritty
    eza
    tealdeer
)

mkdir -p "$BACKUP_DIR"

echo "==> Backing up and removing existing dotfiles if necessary..."
for pkg in "${PACKAGES[@]}"; do
    (
        cd "$DOTFILES_DIR/$pkg" || exit 0
        while IFS= read -r -d '' file; do
            rel="${file#./}"
            target="${HOME}/${rel}"

            if [ -e "$target" ] && [ ! -L "$target" ]; then
                echo "Backing up $target -> $BACKUP_DIR/$rel"
                mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
                mv "$target" "$BACKUP_DIR/$rel"
            fi
        done < <(find . -type f -print0)
    )
done

echo
echo "==> Applying stow packages..."
cd "$DOTFILES_DIR"
for pkg in "${PACKAGES[@]}"; do
    echo " - stow $pkg"
    stow "$pkg"
done

echo
echo "==> Dotfiles applied successfully."
echo "Backups stored in: $BACKUP_DIR"
