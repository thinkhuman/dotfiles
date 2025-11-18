# Dotfiles

A collection of my personal Linux configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).  
This repository lets me keep my environment consistent across machines and makes setup on new systems simple and repeatable.

## Overview

Each application or tool has its own directory under `dotfiles/`.  
Inside each directory, the folder structure mirrors the final location in my home directory.  
Running `stow <package>` creates symlinks from this repository into `$HOME`.

Example:

```
dotfiles/
  bash/
    .bashrc
    .bash_aliases

  starship/
    .config/starship.toml

  alacritty/
    .config/alacritty/alacritty.yml
```

Running:
```
stow bash
```

Creates:
```
~/.bashrc -> dotfiles/bash/.bashrc
~/.bash_aliases -> dotfiles/bash/.bash_aliases
```

## How to Use

Clone the repository into your home directory (or `~/dotfiles` if you prefer):

```bash
git clone git@github.com:<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Then stow each configuration package you want to enable:
```bash
stow bash
stow git
stow starship
stow <yourpackagehere>
```

Stow will create the appropriate symlinks in `$HOME` and `~/.config`.

## Adding New Dotfiles

1. Create a directory under `dotfiles/` named after the tool.
2. Recreate the path to the real file starting from `$HOME`.
3. Move the file from your system into that directory.
4. Remove the original from `$HOME`.
5. Run `stow <package>`.

Example for Starship:
```bash
mkdir -p dotfiles/starship/.config
mv ~/.config/starship.toml dotfiles/starship/.config/
rm ~/.config/starship.toml
stow starship
```

## Notes

- Do **not** store secrets or private keys in this repository.
- Stow operations are safe and reversible.
  `stow -D <package>` removes symlinks without deleting your files.
- This repository is meant to be used on Linux systems.
