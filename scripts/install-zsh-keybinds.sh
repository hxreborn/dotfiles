#!/bin/sh

# install-zsh-keybinds.sh
# POSIX-compliant script to install zsh Emacs-style keybinds standalone
# Idempotent: safe to run multiple times

set -e  # Exit on any error

# Colors for output (fallback to empty if not supported)
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Print colored messages
print_info() { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
print_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
print_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
print_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }

# Configuration
KEYBINDS_DIR="$HOME/.config/zsh"
KEYBINDS_FILE="$KEYBINDS_DIR/zsh-emacs-keybinds.zsh"
ZSHRC_FILE="$HOME/.zshrc"
SOURCE_LINE='[ -f ~/.config/zsh/zsh-emacs-keybinds.zsh ] && source ~/.config/zsh/zsh-emacs-keybinds.zsh'
REPO_URL="https://raw.githubusercontent.com/rafareborn/dotfiles/master/.config/zsh/zsh-emacs-keybinds.zsh"

print_info "Installing zsh Emacs-style keybindings..."

# Create directory if it doesn't exist
if [ ! -d "$KEYBINDS_DIR" ]; then
    print_info "Creating directory: $KEYBINDS_DIR"
    mkdir -p "$KEYBINDS_DIR"
fi

# Download or copy keybinds file
if [ -f ".config/zsh/zsh-emacs-keybinds.zsh" ]; then
    # Running from within the dotfiles repository
    print_info "Copying keybinds file from local repository..."
    cp ".config/zsh/zsh-emacs-keybinds.zsh" "$KEYBINDS_FILE"
else
    # Download from GitHub
    print_info "Downloading keybinds file from GitHub..."
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$REPO_URL" -o "$KEYBINDS_FILE"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$REPO_URL" -O "$KEYBINDS_FILE"
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
fi

print_success "Keybinds file installed to: $KEYBINDS_FILE"

# Handle .zshrc configuration
if [ -f "$ZSHRC_FILE" ]; then
    # Check if source line already exists
    if grep -Fq "$SOURCE_LINE" "$ZSHRC_FILE"; then
        print_info ".zshrc already configured (source line found)"
    else
        # Add source line to .zshrc
        print_info "Adding source line to .zshrc..."
        printf "\n# zsh Emacs-style keybindings\n%s\n" "$SOURCE_LINE" >> "$ZSHRC_FILE"
        print_success "Source line added to .zshrc"
    fi
    
    print_success "Installation complete!"
    print_info "Reload your shell or run: ${BLUE}source ~/.zshrc${NC}"
else
    print_warning ".zshrc not found!"
    print_info "Add this line to your zsh configuration manually:"
    printf "\n    ${GREEN}%s${NC}\n\n" "$SOURCE_LINE"
    print_info "Then reload your shell or run: ${BLUE}source ~/.zshrc${NC}"
fi

print_info "To test keybindings, try:"
print_info "  • ${BLUE}Ctrl+A${NC} - Go to line beginning"
print_info "  • ${BLUE}Ctrl+E${NC} - Go to line end"
print_info "  • ${BLUE}Ctrl+arrows${NC} - Word navigation"
print_info "  • ${BLUE}Alt+f/b${NC} - Forward/backward word"