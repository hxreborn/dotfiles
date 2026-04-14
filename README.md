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
| nvim      | all   | LazyVim config               |
| zsh       | all   | Zsh config                   |
| git       | all   | Git config, local override  |
| ideavim   | all   | IdeaVim for JetBrains       |
| vscode    | all   | VSCode settings, keybindings|
| karabiner | macOS | Karabiner-Elements          |
| waybar    | Linux | Waybar (Wayland)            |

**macOS tiling window managers** (pick one):
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

### [LazyVim](https://github.com/LazyVim/LazyVim)

| Action          | Shortcut       |
|-----------------|----------------|
| File explorer   | `<leader>e`      |
| Find files      | `<leader><space>` |
| Find text       | `<leader>/`       |
| Git status      | `<leader>gs`      |
| Code actions    | `<leader>ca`      |
| Format document | `<leader>cf`      |
| Toggle terminal | `<C-/>`           |

---

### [AeroSpace](https://github.com/nikitabobko/AeroSpace)
macOS tiling window manager, i3-like keybindings

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

---

### [Amethyst](https://github.com/ianyh/Amethyst)
macOS tiling window manager, layout-based

| Action               | Shortcut              |
|----------------------|-----------------------|
| Focus                | ⌃ + Arrows            |
| Move window          | ⌃ + ⇧ + Arrows       |
| Float                | ⌃ + T                 |
| Switch space         | ⌃ + 1-5               |
| Send to space        | ⌃ + ⇧ + 1-5          |
| Cycle layout         | ⌃ + Space             |

---

### [Yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd)
macOS tiling window manager (BSP) + hotkey daemon

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

---

### [OmniWM](https://github.com/BarutSRB/OmniWM)
macOS tiling window manager, dwindle layout

| Action            | Shortcut              |
|-------------------|-----------------------|
| Focus             | ⌥ + Arrows            |
| Move window       | ⌥ + ⇧ + Arrows       |
| Switch workspace  | ⌥ + 1-9               |
| Send to workspace | ⌥ + ⇧ + 1-9          |
| Fullscreen        | ⌥ + F                 |
| Quake terminal    | ⌥ + `                 |
