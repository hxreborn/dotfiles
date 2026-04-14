# dotfiles

GNU Stow + Make. macOS, Arch, Fedora, Ubuntu.

## Setup

```sh
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
```

## Packages

| Package | Platform | Description | Notes |
|---------|----------|-------------|-------|
| [nvim](https://github.com/LazyVim/LazyVim) | all | Neovim (LazyVim) | |
| [zsh](https://github.com/HyDE-Project/HyDE) | all | Zsh (HyDE framework) | |
| git | all | Git config, local override | |
| [ideavim](https://github.com/JetBrains/ideavim) | all | IdeaVim for JetBrains | |
| [vscode](https://code.visualstudio.com) | all | VSCode settings, keybindings | |
| [aerospace](https://github.com/nikitabobko/AeroSpace) | macOS | AeroSpace tiling WM | pick one |
| [yabai-skhd](https://github.com/koekeishiya/yabai) | macOS | Yabai + skhd | SIP off, pick one |
| [omniwm](https://github.com/BarutSRB/OmniWM) | macOS | OmniWM tiling WM | pick one |
| [amethyst](https://github.com/ianyh/Amethyst) | macOS | Amethyst tiling WM | pick one |
| [karabiner](https://karabiner-elements.pqrs.org) | macOS | Karabiner-Elements | |
| [waybar](https://github.com/Alexays/Waybar) | Linux | Waybar (Wayland) | |

## Usage

Fresh machine: `make bootstrap`. Day-to-day: `make all` or `make nvim`. `make restow-<package>` if you add or remove files. `make help` for the full list.

New package: create `<name>/.config/<name>/`, add to the Makefile, `make <name>`.

## Local Overrides

Untracked, per-machine:

- `~/.config/git/config.local` -> email, signing key
- `~/.config/zsh/local.zsh` -> env, PATH

---

## Keybindings

### Neovim

| Action          | Shortcut       |
|-----------------|----------------|
| File explorer   | Leader + e     |
| Find files      | Leader + Space |
| Find text       | Leader + /     |
| Git status      | Leader + g + s |
| Code actions    | Leader + c + a |
| Format document | Leader + c + f |
| Toggle terminal | Ctrl + /       |

Clean reinstall: `rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim && nvim`

### AeroSpace

i3-inspired tiling. Needs Accessibility permission in System Settings.

| Action            | Shortcut              |
|-------------------|-----------------------|
| Focus             | ⌥ + H J K L           |
| Move window       | ⌥ + ⇧ + H J K L      |
| Resize            | ⌥ + ⌃ + H J K L      |
| Fullscreen        | ⌥ + M                 |
| Float             | ⌥ + ⇧ + Space        |
| Switch workspace  | ⌥ + A S D F G         |
| Send to workspace | ⌥ + ⇧ + A-G          |
| Close             | ⌥ + Q                 |

### Amethyst

| Action               | Shortcut              |
|----------------------|-----------------------|
| Focus                | ⌃ + Arrows            |
| Move window          | ⌃ + ⇧ + Arrows       |
| Float                | ⌃ + T                 |
| Switch space         | ⌃ + 1-5               |
| Send to space        | ⌃ + ⇧ + 1-5          |
| Cycle layout         | ⌃ + Space             |

### Yabai + skhd

Keybindings in `~/.config/skhd/skhdrc`.
