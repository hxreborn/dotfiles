# dotfiles

![macOS](https://img.shields.io/badge/macOS-000?logo=apple&logoColor=fff)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=000)

Personal dotfiles, managed with [yadm](https://yadm.io). Paths in the repo mirror `$HOME`.

## Setup

On a fresh machine:

```sh
# macOS: install yadm via Homebrew
brew install yadm

# Linux: install yadm via your package manager (pacman/dnf/apt)
sudo pacman -S yadm

yadm clone https://github.com/hxreborn/dotfiles.git
yadm bootstrap
```

`yadm clone` checks the repo out into `$HOME`. `yadm bootstrap` runs `.config/yadm/bootstrap`, which installs from `Brewfile` on macOS or via `pacman`/`dnf`/`apt` on Linux.

If the clone bails on existing files, move them aside, run `yadm clone --no-bootstrap`, then `yadm reset --hard` and `yadm bootstrap`.

## Workflow

Edit files in `$HOME`, then commit through yadm:

```sh
yadm status
yadm diff
yadm add ~/.config/nvim/init.lua
yadm commit -m "tweak nvim mappings"
yadm push
```

On other machines:

```sh
yadm pull
```

## Layout

Repo paths map straight to `$HOME`:

```text
.zshenv                                          -> ~/.zshenv
.config/nvim/init.lua                            -> ~/.config/nvim/init.lua
.config/karabiner/karabiner.json##os.Darwin      -> ~/.config/karabiner/karabiner.json (macOS only)
.config/satty/config.toml##os.Linux              -> ~/.config/satty/config.toml (Linux only)
Library/Application Support/Code/User/settings.json##os.Darwin  -> macOS VSCode
.config/Code/User/settings.json##os.Linux        -> Linux VSCode
```

The `##os.Darwin` and `##os.Linux` suffixes are yadm alternates. `yadm alt` runs on every commit and materializes the file matching the current `uname`.

## Packages

| Package | Platform | Description |
|---------|----------|-------------|
| nvim      | all   | LazyVim config              |
| zsh       | all   | Zsh config                  |
| git       | all   | Git config, local override  |
| ideavim   | all   | IdeaVim for JetBrains       |
| kitty     | all   | Kitty terminal              |
| fastfetch | all   | Fastfetch system info       |
| lazygit   | all   | Lazygit TUI                 |
| matugen   | all   | Material color generation   |
| vscode    | per OS | VSCode settings, keybindings |
| karabiner | macOS | Karabiner-Elements          |
| satty     | Linux | Satty screenshot annotation |

**macOS tiling window managers** (pick one):
[AeroSpace](https://github.com/nikitabobko/AeroSpace) ·
[Yabai + skhd](https://github.com/koekeishiya/yabai) (SIP off) ·
[OmniWM](https://github.com/BarutSRB/OmniWM) ·
[Amethyst](https://github.com/ianyh/Amethyst)

## Backups

yadm does not back up files it overwrites. Before running `yadm pull` over local changes, run `yadm status` and stash or commit anything you want to keep.

## Local Overrides

Untracked, per-machine:

- `~/.config/git/config.local` -> email, signing key
- `~/.config/zsh/local.zsh` -> env, PATH

Hide them from `yadm status` via the local exclude list:

```sh
echo '.config/git/config.local' >> ~/.config/yadm/repo.git/info/exclude
echo '.config/zsh/local.zsh'   >> ~/.config/yadm/repo.git/info/exclude
```

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
