#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
if [[ $- == *i* ]]; then
    # This is a good place to load graphic/ascii art, display system information, etc.
    if command -v pokego >/dev/null; then
        pokego --no-title -r 1,3,6
    elif command -v pokemon-colorscripts >/dev/null; then
        pokemon-colorscripts --no-title -r 1,3,6
    elif command -v fastfetch >/dev/null; then
        if do_render "image"; then
            fastfetch --logo-type kitty
        fi
    fi
fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
    )
fi

# ── Git Functions ────────────────────────────────────────────
git_current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# ── API Keys ──────────────────────────────────────────────────
# export ZAI_API_KEY=your_api_key_here
# ── Node Version Manager
# ──────────────────────────────────────
# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
export PATH="$HOME/.npm-global/bin:$PATH"
# ── Aliases ───────────────────────────────────────────────────
# Safer file ops
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

# Clipboard (Wayland)
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'

# Readability & color
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias less='less -R'

# Human-readable defaults
alias df='df -h'
alias du='du -h -d 1'
alias free='free -h'

# Directory management
alias mkdir='mkdir -pv'

# Vi overrides + editor exports
unalias v vi vim 2>/dev/null || true
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# ── Word navigation ───────────────────────────────────────────
# Remove / from WORDCHARS so paths are navigated word-by-word
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ── Kitty key bindings ────────────────────────────────────────
# Ctrl+Right/Left for word-by-word autosuggestion navigation
# Bind to both vi and emacs keymaps
bindkey -M viins '^[[1;5C' vi-forward-word      # Ctrl+Right (vi mode)
bindkey -M viins '^[[1;5D' vi-backward-word     # Ctrl+Left (vi mode)
bindkey -M emacs '^[[1;5C' forward-word         # Ctrl+Right (emacs mode)
bindkey -M emacs '^[[1;5D' backward-word        # Ctrl+Left (emacs mode)
