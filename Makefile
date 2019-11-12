DOTFILE  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUDES := .DS_Store .git
TARGETS  := $(wildcard .??*)
DOTFILES := $(filter-out $(EXCLUDES), $(TARGETS))

export NODE_VERSION=12.4.0
export PERL_VERSION=5.22.1
export PYTHON2_VERSION=2.7.16
export PYTHON3_VERSION=3.7.2
export RUBY_VERSION=2.6.5

export ANYENV_ROOT=$(HOME)/.anyenv
export NODENV_ROOT=$(ANYENV_ROOT)/envs/nodenv
export PLENV_ROOT=$(ANYENV_ROOT)/envs/plenv
export PYENV_ROOT=$(ANYENV_ROOT)/envs/pyenv
export RBENV_ROOT=$(ANYENV_ROOT)/envs/rbenv

PATH := $(ANYENV_ROOT)/bin:$(PATH)
PATH := $(NODENV_ROOT)/bin:$(PATH)
PATH := $(PLENV_ROOT)/bin:$(PATH)
PATH := $(PYENV_ROOT)/bin:$(PATH)
PATH := $(RBENV_ROOT)/bin:$(PATH)
export PATH

all: update install deploy

help:
	@echo "make all            #=> Updating, deploying and initializng"
	@echo "make update         #=> Fetch changes"
	@echo "make install        #=> Setup environment"
	@echo "make deploy         #=> Create symlink"
	@echo "make list           #=> List the files"
	@echo "make clean          #=> Remove the dotfiles"

update:
	git pull origin master

install: brew-bundle nodenv plenv pyenv rbenv golang rust

deploy:
	@echo 'Deploy dotfiles.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTFILE)

.PHONY: all help update install deploy list clean

# brew {{{

brew-init:
	@xcode-select --install || :
	@type -a brew >/dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade
	brew tap homebrew/bundle

brew: brew-init
	brew bundle --file=etc/brew/Brewfile

brew-cask: brew-init
	brew bundle --file=etc/brew/Brewfile.cask

brew-cask-update: brew-init
	brew cask update

brew-mas: brew-init
	brew install mas
	brew bundle --file=etc/brew/Brewfile.mas

brew-bundle: brew brew-cask

.PHONY: brew-init brew brew-cask brew-cask-update brew-mas brew-bundle

# }}}

# golang {{{

golang-init: brew-init
	brew install go

golang: golang-init
	@./scripts/golang_tools

.PHONY: golang-init golang

# }}}

# rust {{{

rust-init: brew-init
	brew install rust

rust: rust-init
	@./scripts/rust_tools

.PHONY: rust-init rust

# }}}

# anyenv {{{

anyenv-init:
	@./scripts/anyenv

nodenv: anyenv-init
	@./scripts/nodenv

plenv: anyenv-init
	@./scripts/plenv

pyenv: anyenv-init
	@./scripts/pyenv

rbenv: anyenv-init
	@./scripts/rbenv

.PHONY: anyenv-init nodenv plenv pyenv rbenv

# }}}
