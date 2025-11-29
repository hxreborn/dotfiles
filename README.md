# dotfiles

XDG-compliant dotfiles.

## Index

- [Install](#install)
- [zsh Keybinds Only](#zsh-keybinds-only)
- [VSCode](#vscode)
- [Neovim](#neovim)
- [macOS WMs](#macos-wms)
  - [Amethyst](#amethyst)
  - [AeroSpace](#aerospace)
  - [Yabai + skhd](#yabai--skhd)

## Install

```sh
git clone https://github.com/hxreborn/dotfiles.git
cd dotfiles
./scripts/setup.sh
```

### zsh Keybinds Only

```sh
curl -fsSL https://raw.githubusercontent.com/hxreborn/dotfiles/master/scripts/install-zsh-keybinds.sh | sh
```

## VSCode

```sh
git clone --depth 1 --filter=blob:none --sparse https://github.com/hxreborn/dotfiles.git dotfiles-vscode
cd dotfiles-vscode && git sparse-checkout set .config/vscode
ln -s "$(pwd)/.config/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -s "$(pwd)/.config/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
```

Linux: `~/.config/Code/User/`

## Neovim

LazyVim configuration.

```sh
git clone --depth 1 --filter=blob:none --sparse https://github.com/hxreborn/dotfiles.git dotfiles-nvim
cd dotfiles-nvim && git sparse-checkout set .config/nvim
ln -s "$(pwd)/.config/nvim" "$HOME/.config/nvim"
```

| Action          | Shortcut      |
| --------------- | ------------- |
| File explorer   | Space + e     |
| Find files      | Space + Space |
| Find text       | Space + /     |
| Git status      | Space + g + s |
| Code actions    | Space + c + a |
| Format document | Space + c + f |
| Toggle terminal | Ctrl + /      |

Clean reinstall: `rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && nvim`

---

## macOS WMs

All require Accessibility permission.

### Amethyst

```sh
brew install --cask amethyst
curl -fsSL https://raw.githubusercontent.com/hxreborn/dotfiles/master/.config/amethyst/amethyst.yml -o ~/.amethyst.yml
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
curl -fsSL https://raw.githubusercontent.com/hxreborn/dotfiles/master/.config/aerospace/aerospace.toml -o ~/.aerospace.toml
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
mkdir -p ~/.config/yabai ~/.config/skhd
curl -fsSL https://raw.githubusercontent.com/hxreborn/dotfiles/master/.config/yabai/yabairc -o ~/.config/yabai/yabairc
curl -fsSL https://raw.githubusercontent.com/hxreborn/dotfiles/master/.config/skhd/skhdrc -o ~/.config/skhd/skhdrc
yabai --start-service && skhd --start-service
```

Keybindings in `~/.config/skhd/skhdrc`.
