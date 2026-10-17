MAKEFLAGS += -j$(shell sysctl -n hw.ncpu)

.PHONY: all
all: install

.PHONY: help
help:
	@echo "make all            #=> Deploying and installing"
	@echo "make update         #=> Fetch changes"
	@echo "make install        #=> Setup environment"
	@echo "make bootstrap      #=> Apply mise bootstrap (packages, dotfiles, macOS defaults)"
	@echo "make brew-prune     #=> Uninstall Homebrew packages no longer declared"
	@echo "make rust-update    #=> Update Rust crates"

.PHONY: update
update:
	git pull --no-commit origin main

.PHONY: install
install: mise bat silicon navi herdr sheldon claude

# brew {{{

.PHONY: brew-init
brew-init:
	xcode-select --install 2>/dev/null || :
	./scripts/agree_xcode_license
	./scripts/brew_init

# }}}

# mise bootstrap {{{

# brew_init 直後でも brew/mise を参照できるようにする
# NOTE: PATHが通ってない場合に brew や mise 見つからない場合がある
export PATH := /opt/homebrew/bin:$(PATH)
BREW := /opt/homebrew/bin/brew
MISE := /opt/homebrew/bin/mise

GHQ_ROOT ?= $(HOME)/.ghq
DOTFILES_LOCAL_DIR ?= $(firstword $(wildcard $(GHQ_ROOT)/*/*/dotfiles.local))

# .zshenv 未適用の初回実行でも node の default packages を読めるようにする
export MISE_NODE_DEFAULT_PACKAGES_FILE ?= $(HOME)/.config/mise/default-npm-packages

# auto_updates trueのcaskアプリは自身の更新に委ねる
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS := 1

.PHONY: mise-init
mise-init: brew-init
	./scripts/mise_init

# DOTFILES_LOCAL_DIR の mise.local.toml を取り込む（@DOTFILES_LOCAL_DIR@ は実際のパスに置換する）
.PHONY: mise-local
mise-local:
	@dir=$$(cd $(or $(DOTFILES_LOCAL_DIR),/nonexistent) 2>/dev/null && pwd); \
	if [ -n "$$dir" ] && [ -f "$$dir/mise.local.toml" ]; then \
		sed "s|@DOTFILES_LOCAL_DIR@|$$dir|g" "$$dir/mise.local.toml" >mise.local.toml; \
	fi

.PHONY: bootstrap
bootstrap: mise-init mise-local
	$(MISE) trust --quiet mise.toml
	@if [ -f mise.local.toml ]; then $(MISE) trust --quiet mise.local.toml; fi
	$(MISE) bootstrap --yes --update
	$(MISE) bootstrap packages upgrade --yes
	@ # mise は自身でインストールしていないcaskを更新しないので、brewで更新する
	$(BREW) upgrade --cask

# 宣言から外したformulaを削除する（caskはmiseがインストールしたものだけが対象）
.PHONY: brew-prune
brew-prune: mise-local
	$(MISE) bootstrap packages prune --manager brew
	$(MISE) bootstrap packages prune --manager brew-cask

# }}}

.PHONY: mise
mise: bootstrap
	$(MISE) up

.PHONY: rust-update
rust-update: mise
	cargo install-update -a

.PHONY: bat
bat: bootstrap
	./scripts/bat
	cd ~/.config/bat && bat cache --build

.PHONY: silicon
silicon: bootstrap
	cd ~/.config/bat && silicon --build-cache

.PHONY: navi
navi: bootstrap
	./scripts/navi

.PHONY: sheldon
sheldon:
	./scripts/sheldon

.PHONY: claude
claude:
	./scripts/claude

.PHONY: herdr
herdr: bootstrap
	./scripts/herdr
