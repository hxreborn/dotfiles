source /usr/share/cachyos-fish-config/cachyos-config.fish

# GPG agent TTY (for git signing, pass, etc.)
set -gx GPG_TTY (tty)

# Bun
fish_add_path ~/.bun/bin

# Override greeting with fastfetch (config.jsonc handles logo + sizing)
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
end

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GIT_EDITOR nvim
alias vim='nvim'
alias v='nvim'

# Colored output
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# bat > cat
alias cat='bat'

# Human-readable defaults
alias df='df -h'
alias du='du -h -d 1'
alias free='free -h'
alias mkdir='mkdir -pv'

# Clipboard (Wayland)
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'

# API keys (separate file, chmod 600)
source ~/.config/fish/secrets.fish

# Pin Claude Code version (prevent npm self-update)
set -gx DISABLE_AUTOUPDATER 1

# Patch Claude Code tool visibility (run manually after updates: patch-claude-verbose)

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

# opencode
fish_add_path /home/rafa/.opencode/bin
