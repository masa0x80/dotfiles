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
	defaults \
	brew-init \
	brew \
	mise \
	python \
	navi \
	bat \
	silicon \
	sheldon \
	passage \
	term-definition

.PHONY: deploy
deploy:
	@echo 'Deploy dotfiles.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

.PHONY: list
list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

.PHONY: clean
clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf$(DOTFILE)

# brew {{{

.PHONY: brew-init
brew-init:
	xcode-select --install 2>/dev/null || :
	./scripts/brew_init

.PHONY: brew
brew:
	brew bundle --file=etc/brew/Brewfile

.PHONY: brew-cask
brew-cask:
	brew bundle --file=etc/brew/Brewfile.cask

.PHONY: brew-mas
brew-mas:
	brew bundle --file=etc/brew/Brewfile.mas

# }}}

# defaults {{{

.PHONY: defaults
defaults:
	./scripts/defaults

# }}}

# mise {{{

.PHONY: mise
mise:
	mise plugin upgrade
	mise install -y

.PHONY: python
python: mise
	pip install --upgrade pip

# rust {{{

.PHONY: rust-update
rust-update: mise
	cargo install-update -a

# }}}

# }}}

.PHONY: bat
bat: brew
	cd ~/.config/bat && bat cache --build

.PHONY: silicon
silicon: brew
	cd ~/.config/bat && silicon --build-cache

.PHONY: navi
navi: brew
	./scripts/navi

.PHONY: sheldon
sheldon:
	./scripts/sheldon

.PHONY: passage
passage:
	./scripts/passage

.PHONY: term-definition
term-definition:
	./scripts/term-definition
