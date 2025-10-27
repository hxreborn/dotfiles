#!/usr/bin/env zsh
# Comprehensive Emacs-style keybindings for ZSH
# Combines standard bash/readline keybindings with robust terminal compatibility

# Load ZLE module and reset to stock defaults for clean slate
zmodload -i zsh/zle
bindkey -d          # reset to stock
bindkey -e          # Emacs widgets

# bind_emacs SEQ WIDGET -> bind in active map + emacs (init orders vary)
# This ensures bindings work regardless of when the keymap is initialized
bind_emacs() { bindkey "$1" "$2"; bindkey -M emacs "$1" "$2"; }

# ── Arrow Keys ────────────────────────────────────────────────────────────────
bind_emacs '^[[A' up-line-or-history   # Up
bind_emacs '^[[B' down-line-or-history # Down
bind_emacs '^[[C' forward-char         # Right
bind_emacs '^[[D' backward-char        # Left

# ── Home/End Variants ─────────────────────────────────────────────────────────
# Handle multiple terminal escape code formats
bind_emacs '^[[H' beginning-of-line    # Home (CSI H) - xterm
bind_emacs '^[[F' end-of-line          # End  (CSI F) - xterm
bind_emacs '^[OH' beginning-of-line    # Home (SS3 OH) - some terminals
bind_emacs '^[OF' end-of-line          # End  (SS3 OF) - some terminals
bind_emacs '^[[1~' beginning-of-line   # Home (CSI 1~) - Linux/KP
bind_emacs '^[[4~' end-of-line         # End  (CSI 4~) - Linux/KP

# ── Page Up/Down ──────────────────────────────────────────────────────────────
bind_emacs '^[[5~' up-line-or-history   # Page Up
bind_emacs '^[[6~' down-line-or-history # Page Down

# ── Insert/Delete ─────────────────────────────────────────────────────────────
bind_emacs '^[[2~' overwrite-mode # Insert (CSI 2~)
bind_emacs '^[[3~' delete-char    # Delete (CSI 3~)

# ── Core Emacs Control Keys ───────────────────────────────────────────────────
# Movement
bind_emacs '^A' beginning-of-line # Ctrl+A - start of line
bind_emacs '^E' end-of-line       # Ctrl+E - end of line
bind_emacs '^F' forward-char      # Ctrl+F - forward char
bind_emacs '^B' backward-char     # Ctrl+B - backward char

# Editing
bind_emacs '^K' kill-line         # Ctrl+K - kill from cursor to end
bind_emacs '^U' kill-whole-line   # Ctrl+U - kill entire line
bind_emacs '^W' backward-kill-word # Ctrl+W - delete word backward
bind_emacs '^Y' yank              # Ctrl+Y - paste from kill ring
bind_emacs '^T' transpose-chars   # Ctrl+T - swap characters
bind_emacs '^L' clear-screen      # Ctrl+L - clear screen

# Delete char or list completions when buffer empty
bind_emacs '^D' delete-char-or-list

# ── Backspace Variants ────────────────────────────────────────────────────────
# Support both DEL (0x7f) and BS (0x08) codes
bind_emacs '^?' backward-delete-char # DEL - common Backspace
bind_emacs '^H' backward-delete-char # BS  - Ctrl+H/tty Backspace

# ── History Navigation ────────────────────────────────────────────────────────
bind_emacs '^P' up-line-or-history   # Ctrl+P - previous command
bind_emacs '^N' down-line-or-history # Ctrl+N - next command
bind_emacs '^R' history-incremental-search-backward # Ctrl+R - search backward
bind_emacs '^S' history-incremental-search-forward  # Ctrl+S - search forward

# ── Alt/Meta Word Operations ──────────────────────────────────────────────────
bind_emacs '^[f' forward-word          # Alt+F - forward word
bind_emacs '^[b' backward-word         # Alt+B - backward word
bind_emacs '^[d' kill-word             # Alt+D - delete word forward
bind_emacs '^[^?' backward-kill-word   # Alt+Backspace (ESC+DEL)
bind_emacs '^[^H' backward-kill-word   # Alt+Backspace (ESC+BS)
bind_emacs '^[.' insert-last-word      # Alt+. - insert last word from previous command

# ── Alt/Meta Case Conversion ──────────────────────────────────────────────────
bind_emacs '^[u' up-case-word       # Alt+U - uppercase word
bind_emacs '^[l' down-case-word     # Alt+L - lowercase word
bind_emacs '^[c' capitalize-word    # Alt+C - capitalize word

# ── Alt/Meta Transpose ────────────────────────────────────────────────────────
bind_emacs '^[t' transpose-words    # Alt+T - swap words

# ── Ctrl+Arrow Keys ───────────────────────────────────────────────────────────
# Word and history navigation with modifier keys (xterm CSI 1;5X format)
bind_emacs '^[[1;5C' forward-word          # Ctrl+Right - forward word
bind_emacs '^[[1;5D' backward-word         # Ctrl+Left - backward word
bind_emacs '^[[1;5A' up-line-or-history    # Ctrl+Up - previous command
bind_emacs '^[[1;5B' down-line-or-history  # Ctrl+Down - next command

# ── Alt+Arrow Keys ────────────────────────────────────────────────────────────
bind_emacs '^[[1;3C' forward-word   # Alt+Right - forward word
bind_emacs '^[[1;3D' backward-word  # Alt+Left - backward word

# ── Ctrl/Alt+Delete ───────────────────────────────────────────────────────────
bind_emacs '^[[3;5~' kill-word          # Ctrl+Delete - delete word forward
# bind_emacs '^[[3;3~' backward-kill-word # Alt+Delete - uncomment if needed

# ── Completion ────────────────────────────────────────────────────────────────
bind_emacs '^I' expand-or-complete      # Tab
bind_emacs '^[[Z' reverse-menu-complete # Shift+Tab

# ── Undo/Redo ─────────────────────────────────────────────────────────────────
bind_emacs '^_' undo      # Ctrl+_ - undo
bind_emacs '^[_' redo     # Alt+_ - redo
bind_emacs '^Xu' undo     # Ctrl+X Ctrl+U - undo alternative

# ── Advanced Editing ──────────────────────────────────────────────────────────
bind_emacs '^[#' pound-insert       # Alt+# - comment line and execute next
bind_emacs '^Q' push-line           # Ctrl+Q - push line to stack
bind_emacs '^[q' push-line-or-edit  # Alt+Q - push line or edit

# Edit command line in $EDITOR (nvim, vim, etc.)
autoload -Uz edit-command-line
zle -N edit-command-line
bind_emacs '^X^E' edit-command-line # Ctrl+X Ctrl+E - open in editor

# ── Troubleshooting & Diagnostics ─────────────────────────────────────────────
#
# Check what escape codes your terminal emits:
#   cat -v              # press key to see escape sequence
#   cat | hexdump -C    # press key to see raw bytes in hex
#
# Example: Ctrl+Right should emit: ESC [ 1 ; 5 C  (shown as ^[[1;5C in cat -v)
#
# Quick manual binding to test:
#   bindkey "^[[1;5C" forward-word
#
# List all bound escape codes:
#   bindkey -L | grep '\^\['
#
# Reset and reload:
#   bindkey -d
#   bindkey -e
#   source ~/.config/zsh/functions/keybindings.zsh
#
# Terminal-specific configuration:
#
# Kitty:
#   kitty +kitten show-key          # show what Kitty intercepts
#   vim ~/.config/kitty/kitty.conf  # edit config to pass keys through
#   map ctrl+left  send_text all \x1b[1;5D
#   map ctrl+right send_text all \x1b[1;5C
#
# Ghostty:
#   vim ~/.config/ghostty/config    # unbind or remap conflicts
#
# macOS Terminal/iTerm2:
#   Preferences → Profiles → Keys
#   - Enable "Use Option as Meta key"
#   - Add custom escape sequences for Ctrl+Arrows if missing
#
# Debugging notes:
#   - If cat -v prints nothing: terminal intercepted the key
#   - If cat -v prints "garbage": those bytes are correct, bind them
#   - If bindings reset: run `bindkey -e` then re-source this file
