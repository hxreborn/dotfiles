# dotfiles

Cross-platform dotfiles following XDG Base Directory specification.

```
dotfiles/
├── .config/              # XDG_CONFIG_HOME (~/.config)
│   ├── aerospace/        # AeroSpace WM config (i3-like tiling)
│   │   └── aerospace.toml
│   ├── amethyst/         # Amethyst config (macOS-native tiling)
│   │   └── amethyst.yml
│   ├── skhd/             # Simple hotkey daemon (keybinds for yabai)
│   │   └── skhdrc
│   ├── yabai/            # Yabai tiling window manager
│   │   └── yabairc
│   └── zsh/              # zsh shell configuration
│       └── zsh-emacs-keybinds.zsh
├── .local/
│   └── share/            # XDG_DATA_HOME (~/.local/share)
│       └── (wallpapers, themes, icons, templates)
├── scripts/              # Installation and setup scripts
│   ├── setup.sh          # Cross-platform bootstrap
│   ├── macos-setup.sh    # macOS installer
│   ├── linux-setup.sh   # Linux installer (placeholder)
│   └── install-zsh-keybinds.sh  # Standalone zsh keybinds installer
└── README.md
```

## Usage

```sh
./scripts/setup.sh
```

### Quick Install - zsh Keybinds Only

Install just the Emacs-style terminal keybindings without the full dotfiles setup:

```sh
curl -fsSL https://raw.githubusercontent.com/rxreborn/dotfiles/master/scripts/install-zsh-keybinds.sh | sh
```

This will:
- Download `zsh-emacs-keybinds.zsh` to `~/.config/zsh/`
- Add source line to `~/.zshrc` (if found and not already present)
- Provide manual setup instructions if needed

---

## Platform-Specific Configs

<details>
<summary><strong>macOS</strong></summary>

### Window Manager Setups

* **Amethyst** — integrates with native macOS Spaces for a smoother trackpad-driven experience ([GitHub](https://github.com/ianyh/Amethyst))
* **AeroSpace** — full tiling model inspired by i3. Currently in beta (v0.18.5); more configurable but may feel clunky for some. ([GitHub](https://github.com/nikitabobko/AeroSpace))
* **Yabai + skhd** — advanced tiling window manager with scriptable configuration and hotkey daemon ([GitHub](https://github.com/koekeishiya/yabai))

---

### Amethyst + macOS Spaces

#### Summary

Minimal configuration for users who prefer macOS Spaces and want light tiling support.

#### Keybindings

| Action                 | Shortcut              |
| ---------------------- | --------------------- |
| Move focus             | ^ + ← ↓ ↑ →           |
| Move window            | ^ + ⇧ + ← ↓ ↑ →       |
| Toggle float mode      | ^ + T                 |
| Reload config          | ^ + ⇧ + R             |
| Switch to Space        | ^ + 1 / 2 / 3 / 4 / 5 |
| Move window to Space   | ^ + ⇧ + 1–5           |
| Cycle layout           | ^ + Space             |
| Toggle layout manually | ^ + L                 |

#### Setup

```sh
brew install --cask amethyst
cp .config/amethyst/amethyst.yml ~/.amethyst.yml
open -a Amethyst
```

Then:

* Grant access under: System Settings → Privacy & Security → Accessibility
* Add to login items
wip:
System Settings → Keyboard → Keyboard Shortcuts

Go to "Mission Control"

Find:

Move left a space (⌃ ←)

Move right a space (⌃ →)

Uncheck both to disable them.
---

### AeroSpace (⌥-based bindings)

#### Summary

Powerful window manager designed for full tiling workflows. Feels more like Linux WMs (e.g., i3). Currently in beta (v0.18.5).

#### Keybindings

| Action             | Shortcut        |
| ------------------ | --------------- |
| Launch Terminal    | ⌥ + Delete      |
| Launch Browser     | ⌥ + B           |
| Launch Finder      | ⌥ + E           |
| Layout: tiles      | ⌥ + /           |
| Layout: accordion  | ⌥ + ^ + ,       |
| Focus movement     | ⌥ + H J K L     |
| Move window        | ⌥ + ⇧ + H J K L |
| Resize window      | ⌥ + ^ + H J K L |
| Smart resize       | ⌥ + , / .       |
| Toggle fullscreen  | ⌥ + M           |
| Toggle floating    | ⌥ + ⇧ + Space   |
| Switch workspace   | ⌥ + A S D F G   |
| Send window to WS  | ⌥ + ⇧ + A–G     |
| Back workspace     | ⌥ + Tab         |
| Move WS to monitor | ⌥ + ⇧ + Tab     |
| Close window       | ⌥ + Q           |
| Reload config      | ^ + ⌥ + R       |

#### Setup

```sh
cp .config/aerospace/aerospace.toml ~/.aerospace.toml
open -a AeroSpace
```

Then:

* Grant access under: System Settings → Privacy & Security → Accessibility
* Add to login items

---

### Yabai + skhd (Advanced Tiling)

#### Summary

Scriptable tiling window manager with powerful customization and hotkey daemon for advanced users.

#### Keybindings

*Note: Keybindings are defined in `.config/skhd/skhdrc` and can be fully customized*

#### Setup

```sh
# Install yabai and skhd
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# Copy configurations
cp .config/yabai/yabairc ~/.config/yabai/yabairc
cp .config/skhd/skhdrc ~/.config/skhd/skhdrc

# Start services
yabai --start-service
skhd --start-service
```

Then:

* Grant access under: System Settings → Privacy & Security → Accessibility
* Disable System Integrity Protection (SIP) for advanced features
* Configure scripting additions if needed

</details>

<details>
<summary><strong>Linux</strong></summary>

Placeholder for future expansion. Intended to support:

* Hyprland or other tiling WMs
* KDE Wayland tuning
* Shared setup: `.zshrc`, `.gitconfig`, helper scripts

</details>