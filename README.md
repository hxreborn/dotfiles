# dotfiles

Dotfiles managed with GNU Stow.

## Prerequisites

```sh
# Install stow
# Arch/CachyOS
sudo pacman -S stow

# macOS
brew install stow

# Debian/Ubuntu
sudo apt install stow
```

## Quick Start

```sh
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install individual package
stow nvim

# Install multiple packages
stow nvim zsh waybar

# Remove package
stow -D nvim
```

## Index

- [How Stow Works](#how-stow-works)
- [Available Packages](#available-packages)
- [Neovim](#neovim)
- [zsh](#zsh)
- [VSCode](#vscode)
- [Waybar](#waybar)
- [macOS WMs](#macos-wms)

## How Stow Works

Each directory is a "package" that mirrors your home directory structure:

```
dotfiles/
├── nvim/.config/nvim/      → ~/.config/nvim
├── zsh/.config/zsh/        → ~/.config/zsh
├── waybar/.config/waybar/  → ~/.config/waybar
└── ...
```

Stow creates symlinks from `~` to the repo.

## Available Packages

| Package   | Description                    |
|-----------|--------------------------------|
| nvim      | LazyVim configuration          |
| zsh       | Shell configuration            |
| waybar    | Wayland status bar             |
| vscode    | VSCode settings & keybindings  |
| aerospace | macOS tiling WM                |
| amethyst  | macOS tiling WM                |
| yabai     | macOS tiling WM                |
| skhd      | macOS hotkey daemon            |
| karabiner | macOS keyboard customizer      |

## Neovim

LazyVim configuration.

```sh
cd ~/dotfiles
stow nvim
```

| Action          | Shortcut       |
| --------------- | -------------- |
| File explorer   | Leader + e     |
| Find files      | Leader + Space |
| Find text       | Leader + /     |
| Git status      | Leader + g + s |
| Code actions    | Leader + c + a |
| Format document | Leader + c + f |
| Toggle terminal | Ctrl + /       |

Clean reinstall: `rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && nvim`

## zsh

```sh
cd ~/dotfiles
stow zsh
```

## VSCode

```sh
cd ~/dotfiles
stow vscode
```

Linux: `~/.config/Code/User/`
macOS: `~/Library/Application Support/Code/User/`

## Waybar

```sh
cd ~/dotfiles
stow waybar
```

---

## macOS WMs

All require Accessibility permission.

### Amethyst

```sh
brew install --cask amethyst
cd ~/dotfiles
stow amethyst
```

| Action               | Shortcut              |
| -------------------- | --------------------- |
| Move focus           | ^ + ← ↓ ↑ →           |
| Move window          | ^ + ⇧ + ← ↓ ↑ →       |
| Toggle float         | ^ + T                 |
| Switch to Space      | ^ + 1 / 2 / 3 / 4 / 5 |
| Move window to Space | ^ + ⇧ + 1–5           |
| Cycle layout         | ^ + Space             |

### AeroSpace

i3-inspired tiling. Beta (v0.18.5).

```sh
brew install --cask nikitabobko/tap/aerospace
cd ~/dotfiles
stow aerospace
```

| Action            | Shortcut        |
| ----------------- | --------------- |
| Focus movement    | ⌥ + H J K L     |
| Move window       | ⌥ + ⇧ + H J K L |
| Resize window     | ⌥ + ^ + H J K L |
| Toggle fullscreen | ⌥ + M           |
| Toggle floating   | ⌥ + ⇧ + Space   |
| Switch workspace  | ⌥ + A S D F G   |
| Send to workspace | ⌥ + ⇧ + A–G     |
| Close window      | ⌥ + Q           |

### Yabai + skhd

Requires SIP disabled for full features.

```sh
brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
cd ~/dotfiles
stow yabai skhd
yabai --start-service && skhd --start-service
```

Keybindings in `~/.config/skhd/skhdrc`.
