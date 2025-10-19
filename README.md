# dotfiles

Personal dotfiles repository containing VSCode configuration.

## Structure

```
dotfiles/
├── vscode/                   # VSCode configuration
│   ├── settings.json        # Editor settings, themes, terminal config
│   └── keybindings.json     # Custom keyboard shortcuts
└── README.md
```

## VSCode Configuration

### Features

- **Theme**: GitHub Dark Default with Material Icon Theme
- **Terminal**: Multiple shell profiles (zsh, bash, fish, tmux, kitty, ghostty)
- **Editor**: Auto-format on save, trim whitespace, insert final newline
- **Integration**: Enhanced terminal experience with custom settings

### Key Bindings

- `Shift+Enter`: Send newline in terminal (when terminal is focused)

### Terminal Profiles

- **zsh**: Default shell with login mode
- **bash**: Bash shell with login mode
- **fish**: Fish shell with login mode
- **tmux**: Tmux session management (`tmux new -A -s DEV`)
- **kitty**: Kitty terminal emulator
- **ghostty**: Ghostty terminal emulator (default external terminal)

### Editor Settings

- **Formatting**: Prettier for JSON, CSS, HTML, JavaScript
- **Files**: Auto-trim trailing whitespace, insert final newlines
- **Terminal**: Integrated terminal with GPU acceleration, custom font
- **Git**: Auto-fetch, no sync confirmations
- **Updates**: Disable release notes for faster startup

## Installation

### Quick Setup

```bash
# Clone the repository
git clone https://github.com/hxreborn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Create symbolic links to VSCode configuration
ln -s "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -s "$(pwd)/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
```

### Manual Setup

Copy the files manually to your VSCode User directory:

```bash
# macOS
cp vscode/settings.json "$HOME/Library/Application Support/Code/User/"
cp vscode/keybindings.json "$HOME/Library/Application Support/Code/User/"

# Linux
cp vscode/settings.json "$HOME/.config/Code/User/"
cp vscode/keybindings.json "$HOME/.config/Code/User/"

# Windows
cp vscode/settings.json "%APPDATA%\Code\User\"
cp vscode/keybindings.json "%APPDATA%\Code\User\"
```

## Requirements

- **VSCode**: Modern version with JSON language support
- **Shells**: zsh, bash, fish (optional, based on terminal profiles used)
- **Terminal Emulators**: kitty, ghostty (optional, for external terminal integration)
- **Fonts**: MesloLGL Nerd Font (for terminal glyph support)

## License

MIT License - see LICENSE file for details.