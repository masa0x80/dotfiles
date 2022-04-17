DOTFILE  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUDES := .DS_Store .git
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
install: defaults brew asdf nodejs python ruby terraform helm sops trivy go rust navi

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
	-rm -rf $(DOTFILE)

# brew {{{

.PHONY: brew-init
brew-init:
	xcode-select --install 2>/dev/null || :
	./scripts/brew_init

.PHONY: brew
brew: brew-init
	brew bundle --file=etc/brew/Brewfile

.PHONY: brew-cask
brew-cask: brew-init
	brew bundle --file=etc/brew/Brewfile.cask

.PHONY: brew-cask-upgrade
brew-cask-upgrade: brew-init
	brew cask upgrade

.PHONY: brew-mas
brew-mas: brew-init
	brew bundle --file=etc/brew/Brewfile.mas

.PHONY: brew-bundle
brew-bundle: brew

# }}}

# defaults {{{

.PHONY: defaults
defaults:
	./scripts/defaults

# }}}

# go {{{

.PHONY: go
go: brew-init
	./scripts/go

# }}}

# rust {{{

.PHONY: rust
rust: brew-init
	./scripts/rust

.PHONY: rust-update
rust-update: rust
	cargo install-update -a

# }}}

# asdf {{{

.PHONY: asdf
asdf: brew-init
	./scripts/asdf

.PHONY: ruby
ruby: asdf
	./scripts/ruby

.PHONY: python
python: asdf
	./scripts/python

.PHONY: terraform
terraform: asdf
	./scripts/terraform

.PHONY: helm
helm: asdf
	./scripts/helm

.PHONY: sops
sops: asdf
	./scripts/sops

.PHONY: trivy
trivy: asdf
	./scripts/trivy

# }}}

.PHONY: nodejs
nodejs: brew-init
	./scripts/nodejs

.PHONY: navi
navi: brew
	./scripts/navi
