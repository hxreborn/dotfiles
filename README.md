# dotfiles

![macOS](https://img.shields.io/badge/macOS-000?logo=apple&logoColor=fff)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=000)

Personal dotfiles managed with GNU Stow and Make. Works on macOS, Arch, Fedora, and Ubuntu-based systems.

## Setup

```sh
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
```

## Packages

| Package | Platform | Description |
|---------|----------|-------------|
| nvim      | all   | Neovim (LazyVim)            |
| zsh       | all   | Zsh (HyDE framework)        |
| git       | all   | Git config, local override  |
| ideavim   | all   | IdeaVim for JetBrains       |
| vscode    | all   | VSCode settings, keybindings|
| karabiner | macOS | Karabiner-Elements          |
| waybar    | Linux | Waybar (Wayland)            |

**macOS WMs** (pick one):
[AeroSpace](https://github.com/nikitabobko/AeroSpace) ·
[Yabai + skhd](https://github.com/koekeishiya/yabai) (SIP off) ·
[OmniWM](https://github.com/BarutSRB/OmniWM) ·
[Amethyst](https://github.com/ianyh/Amethyst)

## Usage

```sh
make bootstrap          # first time
make all                # apply everything
make nvim               # apply one package
make restow-nvim        # after adding/removing files in a package
make help               # all targets
```

For new packages: create `<name>/.config/<name>/`, add to the Makefile, `make <name>`.

## Local Overrides

Untracked, per-machine:

- `~/.config/git/config.local` -> email, signing key
- `~/.config/zsh/local.zsh` -> env, PATH

## Keybindings

### [Neovim](https://github.com/LazyVim/LazyVim)
LazyVim distribution

| Action          | Shortcut       |
|-----------------|----------------|
| File explorer   | Leader + e     |
| Find files      | Leader + Space |
| Find text       | Leader + /     |
| Git status      | Leader + g + s |
| Code actions    | Leader + c + a |
| Format document | Leader + c + f |
| Toggle terminal | Ctrl + /       |

### [AeroSpace](https://github.com/nikitabobko/AeroSpace)
i3-inspired tiling WM

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

### [Amethyst](https://github.com/ianyh/Amethyst)
Automatic tiling WM

| Action               | Shortcut              |
|----------------------|-----------------------|
| Focus                | ⌃ + Arrows            |
| Move window          | ⌃ + ⇧ + Arrows       |
| Float                | ⌃ + T                 |
| Switch space         | ⌃ + 1-5               |
| Send to space        | ⌃ + ⇧ + 1-5          |
| Cycle layout         | ⌃ + Space             |

### [Yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd)
BSP tiling WM + hotkey daemon

| Action            | Shortcut                    |
|-------------------|-----------------------------|
| Focus             | ⌥ + Arrows                  |
| Resize            | ⌥ + ⇧ + Arrows             |
| Swap              | ⌥ + ⌃ + ⇧ + Arrows         |
| Float             | ⌥ + W                       |
| Fullscreen        | ⇧ + F11                     |
| Rotate layout     | ⌥ + R                       |
| Switch workspace  | ⌥ + 1-9                     |
| Send to workspace | ⌥ + ⇧ + 1-9                |
| Terminal          | ⌥ + T                       |
| Browser           | ⌥ + B                       |

### [OmniWM](https://github.com/BarutSRB/OmniWM)
Dwindle tiling WM

| Action            | Shortcut              |
|-------------------|-----------------------|
| Focus             | ⌥ + Arrows            |
| Move window       | ⌥ + ⇧ + Arrows       |
| Switch workspace  | ⌥ + 1-9               |
| Send to workspace | ⌥ + ⇧ + 1-9          |
| Fullscreen        | ⌥ + F                 |
| Quake terminal    | ⌥ + `                 |
