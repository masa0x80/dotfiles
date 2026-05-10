DOTFILE  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUDES := .DS_Store .git .luarc.json
TARGETS  := $(wildcard .??*)
DOTFILES := $(filter-out $(EXCLUDES), $(TARGETS))

.PHONY: all
all: deploy install

.PHONY: help
help:
	@echo "make all            #=> Updating, deploying and installing"
	@echo "make update         #=> Fetch changes"
	@echo "make install        #=> Setup environment"
	@echo "make deploy         #=> Create symlink"
	@echo "make list           #=> List the files"
	@echo "make clean          #=> Remove the dotfiles"

.PHONY: update
update:
	git pull --no-commit origin main

.PHONY: install
install: \
	brew-init \
	nix-init \
	nix \
	mise \
	navi \
	tmux-plugins \
	bat \
	silicon \
	sheldon \
	claude \
	passage \
	term-definition \
	gen-zshrc

.PHONY: deploy
deploy:
	@echo 'Deploy dotfiles.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@if [ -n "$(DOTFILE_LOCAL)" ] && [ -d "$(DOTFILE_LOCAL)" ]; then \
		echo ''; \
		$(MAKE) -C $(DOTFILE_LOCAL) deploy; \
	fi

.PHONY: list
list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

.PHONY: clean
clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILE)

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
nix-init:
	./scripts/nix_init

.PHONY: nix
nix:
	sudo $(NIX) run nix-darwin -- switch --flake .#default --impure

.PHONY: nix-update
nix-update:
	@COMMIT=$$(curl -s "https://api.github.com/repos/NixOS/nixpkgs/commits?sha=nixpkgs-unstable&until=$$(/bin/date -v-$(MIN_RELEASE_DAYS)d +%Y-%m-%dT00:00:00Z)&per_page=1" | jq -r '.[0].sha') && \
	echo "Updating nixpkgs to commit: $$COMMIT ($(MIN_RELEASE_DAYS) days old)" && \
	$(NIX) flake update nixpkgs --override-input nixpkgs "github:NixOS/nixpkgs/$$COMMIT"

# }}}

# mise {{{

.PHONY: mise
mise:
	mise plugin upgrade
	mise install -y
	mise up

# rust {{{

.PHONY: rust-update
rust-update: mise
	cargo install-update -a

# }}}

# }}}

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
sheldon:
	./scripts/sheldon

.PHONY: claude
claude:
	./scripts/claude

.PHONY: passage
passage:
	./scripts/passage

.PHONY: tmux-plugins
tmux-plugins:
	./scripts/tmux-plugins

.PHONY: term-definition
term-definition:
	./scripts/term-definition

.PHONY: gen-zshrc
gen-zshrc:
	./scripts/gen-zshrc
