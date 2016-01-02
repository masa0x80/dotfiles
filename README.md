# Dotfiles

## Overview

下記ツールをインストールします。

- zsh
- vim
- tmux
- peco
- pt
- jq
- direnv
- rbenv
- pyenv
- ndenv
- dotfiles

ツールのインストールにはMacではHomebrewを、CentOSではAnsibleを使います。
その後、各dotfilesへのシンボリックリンクを $HOME の下に作ります。

## Installation

事前にsudoできるように設定し、プロキシーの設定が必要な場合は別途行って下さい。

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

gitのユーザー設定は、`$HOME/.gitconfig.local` に書いて下さい。

```
# .gitconfig.local の例
[user]
	name  = masa0x80
	email = masa0x80@gmail.com
```
