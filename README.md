# dotfiles

![macOS](https://img.shields.io/badge/macOS-000?logo=apple&logoColor=fff)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=000)

Personal dotfiles managed with GNU Stow and Make. Works on macOS, Arch, Fedora, and Debian-based systems.

## Setup

```sh
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
```

## Packages

| Package | Platform | Description |
|---------|----------|-------------|
| `nvim`      | all   | LazyVim config               |
| `zsh`       | all   | Zsh config                   |
| `git`       | all   | Git config, local override   |
| `ideavim`   | all   | IdeaVim for JetBrains        |
| `kitty`     | all   | Kitty terminal               |
| `fastfetch` | all   | Fastfetch system info        |
| `lazygit`   | all   | Lazygit TUI                  |
| `vscode`    | all   | VSCode settings, keybindings |
| `karabiner` | macOS | Karabiner-Elements           |
| `waybar`    | Linux | Waybar                       |
| `satty`     | Linux | Satty screenshot annotation  |

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

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer |
| `<leader><space>` | Find files |
| `<leader>/` | Find text |
| `<leader>gs` | Git status |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format document |
| `<C-/>` | Toggle terminal |

---

### [AeroSpace](https://github.com/nikitabobko/AeroSpace)
macOS tiling window manager, i3-like keybindings

| Key | Action |
|-----|--------|
| `⌥ + H J K L` | Focus |
| `⌥ + ⇧ + H J K L` | Move window |
| `⌥ + ⌃ + H J K L` | Resize |
| `⌥ + M` | Fullscreen |
| `⌥ + ⇧ + Space` | Float |
| `⌥ + A S D F G` | Switch workspace |
| `⌥ + ⇧ + A-G` | Send to workspace |
| `⌥ + Q` | Close |

---

### [Amethyst](https://github.com/ianyh/Amethyst)
macOS tiling window manager, layout-based

| Key | Action |
|-----|--------|
| `⌃ + Arrows` | Focus |
| `⌃ + ⇧ + Arrows` | Move window |
| `⌃ + T` | Float |
| `⌃ + 1-5` | Switch space |
| `⌃ + ⇧ + 1-5` | Send to space |
| `⌃ + Space` | Cycle layout |

---

### [Yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd)
macOS tiling window manager, BSP + hotkey daemon

| Key | Action |
|-----|--------|
| `⌥ + Arrows` | Focus |
| `⌥ + ⇧ + Arrows` | Resize |
| `⌥ + ⌃ + ⇧ + Arrows` | Swap |
| `⌥ + W` | Float |
| `⇧ + F11` | Fullscreen |
| `⌥ + R` | Rotate layout |
| `⌥ + 1-9` | Switch workspace |
| `⌥ + ⇧ + 1-9` | Send to workspace |
| `⌥ + T` | Terminal |
| `⌥ + B` | Browser |

---

### [OmniWM](https://github.com/BarutSRB/OmniWM)
macOS tiling window manager, dwindle layout

| Key | Action |
|-----|--------|
| `⌥ + Arrows` | Focus |
| `⌥ + ⇧ + Arrows` | Move window |
| `⌥ + 1-9` | Switch workspace |
| `⌥ + ⇧ + 1-9` | Send to workspace |
| `⌥ + F` | Fullscreen |
| `` ⌥ + ` `` | Quake terminal |
