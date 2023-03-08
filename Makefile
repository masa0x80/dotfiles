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
install: defaults brew asdf nodejs python ruby java gradle terraform helm go rust sops aws-vault neovim navi bat silicon

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

.PHONY: java
java: asdf
	./scripts/java

.PHONY: go
go: brew-init
	./scripts/go

.PHONY: gradle
gradle: asdf
	./scripts/gradle

.PHONY: terraform
terraform: asdf
	./scripts/terraform

.PHONY: helm
helm: asdf
	./scripts/helm

.PHONY: nodejs
nodejs: brew-init
	./scripts/nodejs

.PHONY: sops
sops: brew-init
	./scripts/sops

.PHONY: aws-vault
aws-vault: brew-init
	./scripts/aws-vault

.PHONY: neovim
neovim: brew-init
	./scripts/neovim

# rust {{{

.PHONY: rust
rust: brew-init
	./scripts/rust

.PHONY: rust-update
rust-update: rust
	cargo install-update -a

# }}}

# }}}

.PHONY: bat
bat: brew
	cd ~/.config/bat; bat cache --build

.PHONY: silicon
silicon: brew
	cd ~/.config/bat; silicon --build-cache

.PHONY: navi
navi: brew
	./scripts/navi
