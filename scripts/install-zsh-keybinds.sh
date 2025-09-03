#!/usr/bin/env bash
# shellcheck disable=SC2155

set -euo pipefail
IFS=$'\n\t'

#--------------------- Globals ----------------------#
ZSH_CONF_DIR="${HOME}/.config/zsh"
KEYBINDS_FILE="zsh-emacs-keybinds.zsh"
KEYBINDS_LOCAL_PATH="${ZSH_CONF_DIR}/${KEYBINDS_FILE}"
ZSHRC="${HOME}/.zshrc"
KEYBINDS_URL=""

#-------------------- Functions ---------------------#
detect_repo_url() {
    local args url
    args=$(ps -o args= $$) || {
        printf 'Unable to inspect process arguments\n' >&2
        return 1
    }

    url=$(grep -oE 'https://[^ ]*install-zsh-keybinds\.sh' <<<"$args" || true)
    [[ -z $url ]] && return 1

    KEYBINDS_URL="${url%/scripts/install-zsh-keybinds.sh}/.config/zsh/${KEYBINDS_FILE}"
}

download_keybinds() {
    mkdir -p "$ZSH_CONF_DIR"
    if ! curl -fsSL "$KEYBINDS_URL" -o "$KEYBINDS_LOCAL_PATH"; then
        printf 'Failed to download %s\n' "$KEYBINDS_URL" >&2
        return 1
    fi
    printf 'Keybinds saved to %s\n' "$KEYBINDS_LOCAL_PATH"
}

update_zshrc() {
    local entry="[ -f ~/.config/zsh/${KEYBINDS_FILE} ] && source ~/.config/zsh/${KEYBINDS_FILE}"
    if [[ -f $ZSHRC ]]; then
        grep -qF "$KEYBINDS_FILE" "$ZSHRC" || printf '%s\n' "$entry" >>"$ZSHRC"
    else
        printf '%s\n' "$entry" >"$ZSHRC"
    fi
    printf 'Updated %s\n' "$ZSHRC"
}

main() {
    KEYBINDS_URL=${1:-}
    [[ -z $KEYBINDS_URL ]] && detect_repo_url || true
    [[ -z $KEYBINDS_URL ]] && {
        printf 'Usage: %s <KEYBINDS_URL>\n' "${0##*/}" >&2
        exit 1
    }

    download_keybinds
    update_zshrc
}

main "$@"
