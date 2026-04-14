# dotfiles

GNU Stow + Make. macOS, Arch, Fedora, Ubuntu.

## Setup

```sh
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
```

## Packages

| Package   | Platform | Description                     |
|-----------|----------|---------------------------------|
| nvim      | all      | Neovim (LazyVim)                |
| zsh       | all      | Zsh (HyDE framework)           |
| git       | all      | Git config, local override      |
| ideavim   | all      | IdeaVim for JetBrains           |
| vscode    | all      | VSCode settings, keybindings    |
| aerospace  | macOS    | AeroSpace tiling WM            |
| yabai-skhd | macOS    | Yabai + skhd (SIP off)         |
| omniwm     | macOS    | OmniWM tiling WM               |
| amethyst   | macOS    | Amethyst tiling WM              |
| karabiner  | macOS    | Karabiner-Elements              |
| waybar     | Linux    | Waybar (Wayland)                |

Pick one WM. AeroSpace, yabai-skhd, omniwm, and amethyst conflict with each other.

## Usage

Fresh machine: `make bootstrap`. Day-to-day: `make all` or `make nvim`. See `make help` for every target.

`make restow-<package>` after adding or removing files from a package.

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

```sh
brew install --cask nikitabobko/tap/aerospace
```

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

```sh
brew install --cask amethyst
```

| Action               | Shortcut              |
|----------------------|-----------------------|
| Focus                | ⌃ + Arrows            |
| Move window          | ⌃ + ⇧ + Arrows       |
| Float                | ⌃ + T                 |
| Switch space         | ⌃ + 1-5               |
| Send to space        | ⌃ + ⇧ + 1-5          |
| Cycle layout         | ⌃ + Space             |

### Yabai + skhd

Disable SIP partially for full features.

```sh
brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
yabai --start-service && skhd --start-service
```

Keybindings in `~/.config/skhd/skhdrc`.
