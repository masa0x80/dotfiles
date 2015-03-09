# Dotfiles

## Overview

下記ツールをインストールします。

- zsh
- vim
- tmux
- peco
- pt
- direnv
- rbenv
- pyenv
- dotfiles

ツールのインストールにはMacではHomebrewを、CentOSではAnsibleを使います。
その後、各dotfilesへのシンボリックリンクを $HOME の下に作ります。

## Installation

事前にsudoできるように設定して下さい。
また、プロキシーの設定が必要な場合は別途行って下さい。

1. `git clone https://github.com/masa0x80/dotfiles.git ~/dotfiles`
2. `cd ~/dotfiles && make init`
3. `cd ~/dotfiles && make deploy`

gitのユーザー設定などは、`$HOME/.gitconfig.local` に書いて下さい。

```
# .gitconfig.local の例
[user]
	name  = masa0x80
	email = masa0x80@gmail.com
```
