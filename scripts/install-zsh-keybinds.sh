#!/bin/sh
set -e

# Auto-detect repo URL from script location
SCRIPT_URL=$(ps -o args= $$ | grep -o 'https://[^|]*install-zsh-keybinds.sh' || echo "")
if [ -n "$SCRIPT_URL" ]; then
    BASE_URL=${SCRIPT_URL%/scripts/install-zsh-keybinds.sh}
    KEYBINDS_URL="$BASE_URL/.config/zsh/zsh-emacs-keybinds.zsh"
else
    echo "Could not detect repo URL. Set KEYBINDS_URL manually."
    exit 1
fi

mkdir -p "$HOME/.config/zsh"
curl -fsSL "$KEYBINDS_URL" -o "$HOME/.config/zsh/zsh-emacs-keybinds.zsh"

if [ -f "$HOME/.zshrc" ] && ! grep -q "zsh-emacs-keybinds.zsh" "$HOME/.zshrc"; then
    echo "[ -f ~/.config/zsh/zsh-emacs-keybinds.zsh ] && source ~/.config/zsh/zsh-emacs-keybinds.zsh" >> "$HOME/.zshrc"
    echo "Added to .zshrc - reload shell"
elif [ ! -f "$HOME/.zshrc" ]; then
    echo "Add to your .zshrc: [ -f ~/.config/zsh/zsh-emacs-keybinds.zsh ] && source ~/.config/zsh/zsh-emacs-keybinds.zsh"
fi