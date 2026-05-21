MAKEFLAGS += -j$(shell sysctl -n hw.ncpu)
DOTFILES_LOCAL_DIR ?= $(HOME)/.ghq/github.com/masa0x80/dotfiles.local

.PHONY: all
all: install

.PHONY: help
help:
	@echo "make all            #=> Deploying and installing"
	@echo "make update         #=> Fetch changes"
	@echo "make install        #=> Setup environment"
	@echo "make nix-update     #=> Update nixpkgs flake input"
	@echo "make rust-update    #=> Update Rust crates"

.PHONY: update
update:
	git pull --no-commit origin main

.PHONY: install
install: mise bat silicon navi mise tmux-plugins sheldon claude term-definition gen-zshrc

# brew {{{

.PHONY: brew-init
brew-init:
	xcode-select --install 2>/dev/null || :
	./scripts/brew_init

# }}}

# nix {{{

MIN_RELEASE_DAYS ?= 7
NIX := /nix/var/nix/profiles/default/bin/nix

.PHONY: nix-init
nix-init: brew-init
	./scripts/nix_init

.PHONY: nix
nix: nix-init
	sudo DOTFILES_LOCAL_DIR=$(DOTFILES_LOCAL_DIR) $(if $(shell command -v gh 2>/dev/null),NIX_CONFIG="access-tokens = github.com=$$(gh auth token)") $(NIX) run nix-darwin -- switch --flake .#default --impure

.PHONY: nix-update
nix-update:
	@COMMIT=$$(curl -sf $(if $(shell command -v gh 2>/dev/null),-H "Authorization: token $$(gh auth token)") "https://api.github.com/repos/NixOS/nixpkgs/commits?sha=nixpkgs-unstable&until=$$(/bin/date -v-$(MIN_RELEASE_DAYS)d +%Y-%m-%dT00:00:00Z)&per_page=1" | jq -re '.[0].sha') || { echo "Failed to fetch nixpkgs commit"; exit 1; }; \
	echo "Updating nixpkgs to commit: $$COMMIT ($(MIN_RELEASE_DAYS) days old)" && \
	$(NIX) flake update nixpkgs --override-input nixpkgs "github:NixOS/nixpkgs/$$COMMIT"

# }}}

.PHONY: mise
mise: nix
	mise install -y
	mise up

.PHONY: rust-update
rust-update: mise
	cargo install-update -a

.PHONY: bat
bat: nix
	./scripts/bat
	cd ~/.config/bat && bat cache --build

.PHONY: silicon
silicon: nix
	cd ~/.config/bat && silicon --build-cache

.PHONY: navi
navi: nix
	./scripts/navi

.PHONY: sheldon
sheldon: nix
	./scripts/sheldon

.PHONY: claude
claude:
	./scripts/claude

.PHONY: tmux-plugins
tmux-plugins:
	./scripts/tmux-plugins

.PHONY: term-definition
term-definition:
	./scripts/term-definition

.PHONY: gen-zshrc
gen-zshrc: nix
	./scripts/gen-zshrc
