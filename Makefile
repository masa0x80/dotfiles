DOTPATH  := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUDES := .DS_Store .git
TARGETS  := $(wildcard .??*)
DOTFILES := $(filter-out $(EXCLUDES), $(TARGETS))

all: install

help:
	@echo "make list           #=> List the files"
	@echo "make update         #=> Fetch changes"
	@echo "make deploy         #=> Create symlink"
	@echo "make init           #=> Setup environment"
	@echo "make install        #=> Updating, deploying and initializng"
	@echo "make clean          #=> Remove the dotfiles"

list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

update:
	git pull origin master

deploy:
	@echo 'Deploy dotfiles.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@DOTFILE=$(DOTPATH) cd ./etc/mitamae; bash init.sh

install: update init deploy

clean:
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)
