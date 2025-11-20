# Dotfiles

This repository contains my personal Linux configuration files, managed using GNU Stow.  
It allows me to reproduce my environment on any new machine with minimal manual setup.

## Setup on a New Machine

### 1. Install Git and Stow

```bash
sudo apt install git stow -y
```

### 2. Clone the Repository

```bash
git clone git@github.com:<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Bootstrap Dotfiles

```bash
./bootstrap-dotfiles.sh
```

This script:

- Detects conflicting files  
- Backs them up to `~/dotfiles_backup_<timestamp>`  
- Removes originals  
- Applies stow packages  

### Full Provisioning

If you want to install apps and apply dotfiles at once:

```bash
./provision.sh
```

This installs packages (git, stow, tmux, alacritty, starship, etc.) and uses the bootstrap script to apply dotfiles automatically.

## Notes

- Do **not** store secrets or private keys in this repo.
- Stow operations are reversible using `stow -D <package>`.
