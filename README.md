# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS%20)](#installation)

## Overview

## Installation

好きなところにCloneして `make` を実行すると、 `$HOME` 配下にシンボリックリンクを張り、`nix` を使って各種ツールのインストールを行います。

```sh
git clone https://github.com/masa0x80/dotfiles.local.git ~/.dotfiles.local
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
DOTFILES_LOCAL_DIR=~/.dotfiles.local make
```

## Update packages

### flake.lockを更新

```sh
# nixpkgs更新（7日前公開のもの）
make nix-update

# 14日前公開のものに変更する場合
make nix-update MIN_RELEASE_DAYS=14
```

### 更新を適用

```sh
make nix
```
