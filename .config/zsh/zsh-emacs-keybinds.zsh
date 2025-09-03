# zsh keymap — Emacs mode keybinds

zmodload -i zsh/zle
bindkey -d          # reset to stock
bindkey -e          # Emacs widgets

# bind_emacs SEQ WIDGET -> bind in active map + emacs (init orders vary)
bind_emacs() { bindkey "$1" "$2"; bindkey -M emacs "$1" "$2"; }

# ── arrows ────────────────────────────────────────────────────────────────────
bind_emacs '^[[A' up-line-or-history   # Up
bind_emacs '^[[B' down-line-or-history # Down
bind_emacs '^[[C' forward-char         # Right
bind_emacs '^[[D' backward-char        # Left

# ── home/end variants (xterm, SS3, Linux/KP) ─────────────────────────────────
bind_emacs '^[[H' beginning-of-line  # Home (CSI H)
bind_emacs '^[[F' end-of-line        # End  (CSI F)
bind_emacs '^[OH' beginning-of-line  # Home (SS3 OH)
bind_emacs '^[OF' end-of-line        # End  (SS3 OF)
bind_emacs '^[[1~' beginning-of-line # KP/Linux Home (CSI 1~)
bind_emacs '^[[4~' end-of-line       # KP/Linux End  (CSI 4~)

# ── insert/delete & shift-tab ────────────────────────────────────────────────
bind_emacs '^[[2~' overwrite-mode       # Insert (CSI 2~)
bind_emacs '^[[3~' delete-char          # Delete (CSI 3~)
bind_emacs '^[[Z' reverse-menu-complete # Shift+Tab (CSI Z)

# ── emacs control keys ───────────────────────────────────────────────────────
bind_emacs '^A' beginning-of-line # Ctrl+A
bind_emacs '^E' end-of-line       # Ctrl+E
bind_emacs '^K' kill-line         # Ctrl+K
bind_emacs '^U' kill-whole-line   # Ctrl+U (whole line)
bind_emacs '^L' clear-screen      # Ctrl+L
bind_emacs '^T' transpose-chars   # Ctrl+T
bind_emacs '^Y' yank              # Ctrl+Y

# ── backspace (support DEL and BS) ───────────────────────────────────────────
bind_emacs '^?' backward-delete-char # DEL (0x7f) common Backspace
bind_emacs '^H' backward-delete-char # BS  (0x08) Ctrl+H/tty Backspace
bind_emacs '^W' backward-kill-word   # Ctrl+W

# ── word ops (Alt) ───────────────────────────────────────────────────────────
bind_emacs '^[f' forward-word        # Alt+f
bind_emacs '^[b' backward-word       # Alt+b
bind_emacs '^[d' kill-word           # Alt+d
bind_emacs '^[^?' backward-kill-word # Alt+Backspace as ESC+DEL
bind_emacs '^[^H' backward-kill-word # Alt+Backspace as ESC+BS

# ── ctrl+arrows (xterm CSI 1;5X) ────────────────────────────────────────────
bind_emacs '^[[1;5C' forward-word         # Ctrl+Right
bind_emacs '^[[1;5D' backward-word        # Ctrl+Left
bind_emacs '^[[1;5A' up-line-or-history   # Ctrl+Up
bind_emacs '^[[1;5B' down-line-or-history # Ctrl+Down

# ── intentionally not bound ─────────────────────────────────────────────────
# bind_emacs '^[[3;5~' kill-word          # Ctrl+Delete (CSI 3;5~)
# bind_emacs '^[[3;3~' backward-kill-word # Alt+Delete  (CSI 3;3~)

# ── completion menu (menuselect) ─────────────────────────────────────────────
bindkey -M menuselect '^[[Z' reverse-menu-complete # Shift+Tab: cycle backward
bindkey -M menuselect '^[[A' up-line-or-history    # Up: move selection up
bindkey -M menuselect '^[[B' down-line-or-history  # Down: move selection down
bindkey -M menuselect '^[[C' forward-char          # Right: move selection right
bindkey -M menuselect '^[[D' backward-char         # Left: move selection left

# ── history search ───────────────────────────────────────────────────────────
bindkey '^R' history-incremental-search-backward # Ctrl+R
bindkey '^P' up-line-or-history                  # Ctrl+P
bindkey '^N' down-line-or-history                # Ctrl+N

# ── troubleshoot ─────────────────────────────────────────────────────────────

# press key to see escape codes
# (example: Ctrl+Right should emit ESC [ 1 ; 5 C)
# cat -v

# press key to see raw bytes in hex
# cat | hexdump -C

# quick manual bind to test a sequence
# bindkey "ESC [ 1 ; 5 C" forward-word

# list bound escape codes in current map
# bindkey -L | grep '\^\['

# reset to defaults and reload this file
# bindkey -d
# bindkey -e
# source ~/.zsh/keybindings.zsh

# show what Kitty intercepts
# kitty +kitten show-key

# edit Kitty config to pass Ctrl+Arrows through
# vim ~/.config/kitty/kitty.conf
# map ctrl+left  send_text all \x1b[1;5D
# map ctrl+right send_text all \x1b[1;5C

# edit Ghostty config to unbind or remap conflicts
# vim ~/.config/ghostty/config

# on macOS Terminal/iTerm2, enable Option as Meta
# and add custom escape sequences for Ctrl+Arrows if missing
# Preferences → Profiles → Keys

# if cat -v prints nothing, terminal intercepted it
# if cat -v prints “garbage”, those bytes are correct — bind them
# if bindings reset, run bindkey -e then re-source this file
