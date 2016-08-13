# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)

## Overview

各種dotfilesの配置と下記ツールのインストールを行います。

- zsh
- vim
- tmux
- fzf
- peco
- pt
- jq
- jo
- direnv
- rbenv
- pyenv
- ndenv
- mysql
- postgresql
- redis
- vagrant

## Installation

事前にsudoできるように設定してください。
CentOSの場合、sudoresへの追加は `sudo visudo` を実行し、下記の行のコメントアウトを解除し `sudo usermod -G wheel $USER` を実行すれば完了します。
また、プロキシーの設定が必要な場合は別途行ってください。

```
# %wheel  ALL=(ALL)       NOPASSWD: ALL
```

下記コマンドを実行すると各種ツールのインストールが始まります。

```
curl https://raw.githubusercontent.com/masa0x80/dotfiles/master/etc/install | bash
```

or

```
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make deploy
make init
```

gitのユーザー設定は、`$HOME/.private/git/config` に書いて下さい。

```
# $HOME/.private/git/config の例
[user]
  name  = masa0x80
  email = masa0x80@gmail.com
[core]
  hooksPath = ~/.private/git/hooks
```

## Note

`make deploy` 時に `TAGS` を指定することで特定のツールのインストールを行うことができます。

`TAGS=common make init` を実行すると代表的なツールのみを短時間でインストールすることができます。

## Terminal Profile for Mac

`./etc/data/terminal/Hybrid.terminal` を読み込みTerminal.appのプロファイル設定を行ってください。
