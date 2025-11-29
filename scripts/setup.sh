#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install_nvim_config() {
    local src="${REPO_ROOT}/.config/nvim"
    local dst="${HOME}/.config/nvim"

    if [[ ! -d "$src" ]]; then
        printf 'Error: nvim config not found at %s\n' "$src" >&2
        return 1
    fi

    mkdir -p "${HOME}/.config"

    if [[ -L "$dst" ]]; then
        if [[ "$(readlink "$dst")" == "$src" ]]; then
            printf 'nvim: already linked\n'
            return 0
        fi
        local backup="${dst}.backup.$(date +%Y%m%d-%H%M%S)"
        printf 'nvim: backing up symlink to %s\n' "$backup"
        mv "$dst" "$backup"
    elif [[ -e "$dst" ]]; then
        local backup="${dst}.backup.$(date +%Y%m%d-%H%M%S)"
        printf 'nvim: backing up existing config to %s\n' "$backup"
        mv "$dst" "$backup"
    fi

    ln -s "$src" "$dst"
    printf 'nvim: linked %s -> %s\n' "$dst" "$src"
}

main() {
    printf 'Setting up dotfiles from %s\n\n' "$REPO_ROOT"
    install_nvim_config
    printf '\nSetup complete\n'
}

main "$@"
