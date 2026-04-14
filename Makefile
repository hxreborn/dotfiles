# Usage: make help

DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
STOW     := stow --dir=$(DOTFILES) --target=$(HOME) --verbose=1
UNAME    := $(shell uname -s)

SHARED   := nvim zsh git ideavim
MACOS    := karabiner
LINUX    := waybar

# WMs conflict -> pick one
MACOS_WM := aerospace omniwm yabai-skhd amethyst

ifeq ($(UNAME),Darwin)
  ALL := $(SHARED) $(MACOS)
else
  ALL := $(SHARED) $(LINUX)
endif

STOW_PKGS := $(SHARED) $(MACOS) $(MACOS_WM) $(LINUX)

.PHONY: help
help:
	@echo "make list            show packages for this OS"
	@echo "make all             stow shared + OS-specific packages"
	@echo "make <pkg>           stow one package"
	@echo "make remove-<pkg>    unstow one package"
	@echo "make remove-all      unstow everything"
	@echo "make restow-<pkg>    re-stow after adding/removing files"
	@echo "make restow-all      re-stow everything"
	@echo "make vscode          link vscode settings (cross-platform)"
	@echo "make remove-vscode   unlink vscode settings"
	@echo "make bootstrap       first-time setup: install deps + stow all"
	@echo "make doctor          verify symlinks"
	@echo "make dry-run         preview what 'make all' would do"

.PHONY: list
list:
	@echo "shared:   $(SHARED)"
ifeq ($(UNAME),Darwin)
	@echo "macos:    $(MACOS)"
	@echo "optional: $(MACOS_WM)"
else
	@echo "linux:    $(LINUX)"
endif

.PHONY: all $(STOW_PKGS)
all: $(ALL)

$(STOW_PKGS):
	$(STOW) $@

.PHONY: remove-all
remove-all:
	@for pkg in $(ALL); do \
		echo "unstow $$pkg"; \
		$(STOW) -D $$pkg 2>/dev/null || true; \
	done

remove-%:
	$(STOW) -D $*

.PHONY: restow-all
restow-all:
	@for pkg in $(ALL); do \
		echo "restow $$pkg"; \
		$(STOW) -R $$pkg; \
	done

restow-%:
	$(STOW) -R $*

# vscode paths differ per OS -> symlink manually
.PHONY: vscode remove-vscode
vscode:
ifeq ($(UNAME),Darwin)
	@mkdir -p "$(HOME)/Library/Application Support/Code/User"
	@ln -sf "$(DOTFILES)vscode/settings.json" \
		"$(HOME)/Library/Application Support/Code/User/settings.json"
	@ln -sf "$(DOTFILES)vscode/keybindings.json" \
		"$(HOME)/Library/Application Support/Code/User/keybindings.json"
else
	@mkdir -p "$(HOME)/.config/Code/User"
	@ln -sf "$(DOTFILES)vscode/settings.json" \
		"$(HOME)/.config/Code/User/settings.json"
	@ln -sf "$(DOTFILES)vscode/keybindings.json" \
		"$(HOME)/.config/Code/User/keybindings.json"
endif
	@echo "vscode linked"

remove-vscode:
ifeq ($(UNAME),Darwin)
	@rm -f "$(HOME)/Library/Application Support/Code/User/settings.json"
	@rm -f "$(HOME)/Library/Application Support/Code/User/keybindings.json"
else
	@rm -f "$(HOME)/.config/Code/User/settings.json"
	@rm -f "$(HOME)/.config/Code/User/keybindings.json"
endif
	@echo "vscode unlinked"

.PHONY: bootstrap
bootstrap:
ifeq ($(UNAME),Darwin)
	@command -v brew >/dev/null || { \
		echo "installing homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	}
	brew install stow
	@test -f $(DOTFILES)Brewfile && brew bundle --file=$(DOTFILES)Brewfile || true
else
	@command -v stow >/dev/null || { \
		command -v dnf >/dev/null && sudo dnf install -y stow || \
		command -v apt >/dev/null && sudo apt install -y stow || \
		command -v pacman >/dev/null && sudo pacman -S --noconfirm stow || \
		{ echo "install stow manually"; exit 1; }; \
	}
endif
	@$(MAKE) all
	@$(MAKE) vscode
	@echo "bootstrap complete"

.PHONY: doctor
doctor:
	@ok=0; fail=0; \
	for pkg in $(ALL); do \
		if [ -d "$(DOTFILES)$$pkg" ]; then \
			cd "$(DOTFILES)$$pkg" && \
			find . -type f -not -name '.*' -not -name 'CLAUDE.md' | while read -r f; do \
				f=$${f#./}; \
				target="$(HOME)/$$f"; \
				if [ -L "$$target" ]; then \
					ok=$$((ok + 1)); \
				elif [ -e "$$target" ]; then \
					echo "CONFLICT $$pkg: $$target exists but is not a symlink"; \
					fail=$$((fail + 1)); \
				else \
					echo "MISSING  $$pkg: $$target"; \
					fail=$$((fail + 1)); \
				fi; \
			done; \
		fi; \
	done; \
	if [ "$$fail" -eq 0 ]; then echo "all symlinks ok"; fi

.PHONY: dry-run
dry-run:
	@for pkg in $(ALL); do \
		echo "=== $$pkg ==="; \
		$(STOW) --simulate $$pkg 2>&1 || true; \
		echo ""; \
	done
