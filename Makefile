# Usage: make help

SHELL := /bin/sh
.DEFAULT_GOAL := help
MAKEFLAGS += --no-builtin-rules

DOTFILES := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
UNAME_S  := $(shell uname -s)

STOW      ?= stow
STOW_FLAGS = --dir="$(DOTFILES)" --target="$(HOME)" --verbose=1

SHARED   := nvim zsh git ideavim
MACOS    := karabiner
LINUX    := waybar

# Mutually exclusive window manager packages on macOS
MACOS_WM := aerospace omniwm yabai-skhd amethyst

ALL_PKGS := $(SHARED) $(MACOS) $(MACOS_WM) $(LINUX)

ifeq ($(UNAME_S),Darwin)
  OS_PKGS := $(MACOS)
  VSCODE_USER_DIR := $(HOME)/Library/Application Support/Code/User
else ifeq ($(UNAME_S),Linux)
  OS_PKGS := $(LINUX)
  VSCODE_USER_DIR := $(HOME)/.config/Code/User
else
  $(error Unsupported OS: $(UNAME_S))
endif

ACTIVE_PKGS := $(SHARED) $(OS_PKGS)

define require_pkg
	@case " $(ALL_PKGS) " in \
		*" $* "*) ;; \
		*) echo "Unknown package: $*"; exit 1 ;; \
	esac
endef

.PHONY: help
help:
	@echo "make list            show packages for this OS"
	@echo "make all             stow shared + OS-specific packages"
	@echo "make <pkg>           stow one package"
	@echo "make remove-<pkg>    unstow one package"
	@echo "make remove-all      unstow active packages"
	@echo "make restow-<pkg>    re-stow one package"
	@echo "make restow-all      re-stow active packages"
	@echo "make vscode          link VSCode settings"
	@echo "make remove-vscode   unlink VSCode settings"
	@echo "make bootstrap       install deps + stow active packages"
	@echo "make doctor          verify symlinks point into dotfiles"
	@echo "make dry-run         preview what 'make all' would do"

.PHONY: list
list:
	@echo "shared:   $(SHARED)"
ifeq ($(UNAME_S),Darwin)
	@echo "macos:    $(MACOS)"
	@echo "optional: $(MACOS_WM)"
else
	@echo "linux:    $(LINUX)"
endif
	@echo "active:   $(ACTIVE_PKGS)"

.PHONY: all $(ALL_PKGS)
all: $(ACTIVE_PKGS)

$(ALL_PKGS):
	@$(STOW) $(STOW_FLAGS) "$@"

.PHONY: remove-all
remove-all:
	@for pkg in $(ACTIVE_PKGS); do \
		echo "unstow $$pkg"; \
		$(STOW) $(STOW_FLAGS) -D "$$pkg" || exit $$?; \
	done

remove-%:
	$(call require_pkg)
	@$(STOW) $(STOW_FLAGS) -D "$*"

.PHONY: restow-all
restow-all:
	@for pkg in $(ACTIVE_PKGS); do \
		echo "restow $$pkg"; \
		$(STOW) $(STOW_FLAGS) -R "$$pkg" || exit $$?; \
	done

restow-%:
	$(call require_pkg)
	@$(STOW) $(STOW_FLAGS) -R "$*"

.PHONY: vscode remove-vscode
vscode:
	@mkdir -p "$(VSCODE_USER_DIR)"
	@ln -snf "$(DOTFILES)/vscode/settings.json" "$(VSCODE_USER_DIR)/settings.json"
	@ln -snf "$(DOTFILES)/vscode/keybindings.json" "$(VSCODE_USER_DIR)/keybindings.json"
	@echo "vscode linked"

remove-vscode:
	@rm -f "$(VSCODE_USER_DIR)/settings.json" "$(VSCODE_USER_DIR)/keybindings.json"
	@echo "vscode unlinked"

.PHONY: bootstrap
bootstrap:
ifeq ($(UNAME_S),Darwin)
	@command -v brew >/dev/null 2>&1 || { \
		echo "Homebrew is required: https://brew.sh"; \
		exit 1; \
	}
	@command -v $(STOW) >/dev/null 2>&1 || brew install stow
	@test -f "$(DOTFILES)/Brewfile" && brew bundle --file="$(DOTFILES)/Brewfile" || true
else
	@command -v $(STOW) >/dev/null 2>&1 || { \
		command -v dnf >/dev/null 2>&1 && sudo dnf install -y stow || \
		command -v apt >/dev/null 2>&1 && sudo apt install -y stow || \
		command -v pacman >/dev/null 2>&1 && sudo pacman -S --noconfirm stow || \
		{ echo "Could not install stow automatically. Install it manually."; exit 1; }; \
	}
endif
	@$(MAKE) all
	@$(MAKE) vscode
	@echo "bootstrap complete"

.PHONY: doctor
doctor:
	@tmpf=$$(mktemp); ok=0; \
	for pkg in $(ACTIVE_PKGS); do \
		pkgdir="$(DOTFILES)/$$pkg"; \
		[ -d "$$pkgdir" ] || continue; \
		for src in $$(find "$$pkgdir" -type f); do \
			rel="$${src#$$pkgdir/}"; \
			target="$(HOME)/$$rel"; \
			if [ -L "$$target" ]; then \
				link="$$(readlink "$$target")"; \
				case "$$link" in \
					"$$pkgdir/"*|"$(DOTFILES)/"*) \
						ok=$$((ok + 1)); \
						;; \
					*) \
						echo "WRONG    $$pkg: $$target -> $$link"; \
						echo x >> "$$tmpf"; \
						;; \
				esac; \
			elif [ -e "$$target" ]; then \
				echo "CONFLICT $$pkg: $$target exists but is not a symlink"; \
				echo x >> "$$tmpf"; \
			else \
				echo "MISSING  $$pkg: $$target"; \
				echo x >> "$$tmpf"; \
			fi; \
		done; \
	done; \
	fail=$$(wc -l < "$$tmpf"); \
	rm -f "$$tmpf"; \
	if [ "$$fail" -eq 0 ]; then \
		echo "all symlinks ok ($$ok checked)"; \
	else \
		echo "$$fail problem(s) found"; \
		exit 1; \
	fi

.PHONY: dry-run
dry-run:
	@for pkg in $(ACTIVE_PKGS); do \
		echo "=== $$pkg ==="; \
		$(STOW) $(STOW_FLAGS) --simulate "$$pkg" || exit $$?; \
		echo; \
	done
