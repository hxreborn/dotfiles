#!/bin/sh
set -e

REPO_URL="${DOTFILES_REPO:-https://raw.githubusercontent.com/rafareborn/dotfiles/master}"

mkdir -p "$HOME/.config/zsh"
curl -fsSL "$REPO_URL/.config/zsh/zsh-emacs-keybinds.zsh" -o "$HOME/.config/zsh/zsh-emacs-keybinds.zsh"

if [ -f "$HOME/.zshrc" ] && ! grep -q "zsh-emacs-keybinds.zsh" "$HOME/.zshrc"; then
    echo "[ -f ~/.config/zsh/zsh-emacs-keybinds.zsh ] && source ~/.config/zsh/zsh-emacs-keybinds.zsh" >> "$HOME/.zshrc"
    echo "Added to .zshrc - reload shell"
elif [ ! -f "$HOME/.zshrc" ]; then
    echo "Add to your .zshrc: [ -f ~/.config/zsh/zsh-emacs-keybinds.zsh ] && source ~/.config/zsh/zsh-emacs-keybinds.zsh"
fi