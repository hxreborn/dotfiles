# dotfiles

Cross-platform dotfiles for macOS and Linux.

```
dotfiles/
├── macos/
│   ├── aerospace/        # AeroSpace WM config (i3-like, powerful — currently in beta, may feel clunky)
│   │   └── aerospace.toml
│   ├── amethyst/         # Amethyst config (macOS-native, simpler feel)
│   │   └── .amethyst.yml
│   ├── zsh/              # macOS shell setup
│   │   └── .zshrc
│   └── setup.sh          # macOS installer script
├── linux/
│   └── setup.sh          # Placeholder for Linux (e.g. Hyprland)
├── setup.sh              # Cross-platform bootstrap
```

## Usage

```sh
./setup.sh
```

---

## Platform-Specific Configs

<details>
<summary><strong>macOS</strong></summary>

### Window Manager Setups

* **Amethyst** — integrates with native macOS Spaces for a smoother trackpad-driven experience ([GitHub](https://github.com/ianyh/Amethyst))
* **AeroSpace** — full tiling model inspired by i3. Currently in beta (v0.18.5); more configurable but may feel clunky for some. ([GitHub](https://github.com/nikitabobko/AeroSpace)).

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
cp macos/amethyst/.amethyst.yml ~/.amethyst.yml
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
cp macos/aerospace/aerospace.toml ~/.aerospace.toml
open -a AeroSpace
```

Then:

* Grant access under: System Settings → Privacy & Security → Accessibility
* Add to login items


</details>

<details>
<summary><strong>Linux</strong></summary>

Placeholder for future expansion. Intended to support:

* Hyprland or other tiling WMs
* KDE Wayland tuning
* Shared setup: `.zshrc`, `.gitconfig`, helper scripts

</details>