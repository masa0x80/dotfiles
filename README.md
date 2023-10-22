# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS%20)](#installation)

## Overview

## Installation

好きなところにCloneして `make` を実行すると、 `$HOME` 配下にシンボリックリンクを張り、`brew` などを使って各種ツールのインストールを行います。

```sh
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

## After Installation

### Git Config

デフォルトではGitの設定が行われません。  
下記要領でファイルを準備して名前やメールアドレスの設定を行ってください。

```sh
$ mkdir -p $HOME/.config.local/git
$ cat <<EOF > $HOME/.config.local/git/config
[user]
  name  = YOUR_NAME
  email = YOUR_EMAIL
[core]
  hooksPath = ~/.config.local/git/hooks
[url "git@github.com:"]
  insteadOf = https://github.com/
EOF
```

ref. <https://github.com/masa0x80/dotfiles.local>
