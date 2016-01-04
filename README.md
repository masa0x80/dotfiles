# Dotfiles

## Overview

下記ツールをインストールします。

- zsh
- vim
- tmux
- fzf
- peco
- pt
- jq
- direnv
- rbenv
- pyenv
- mysql
- dotfiles

まず、dotfilesへのシンボリックリンクを $HOME の下に作成します。
その後、MacではHomebrewを、CentOSではAnsibleを使い各種ツールのインストールを行います。

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

gitのユーザー設定は、`$HOME/.gitconfig.local` に書いて下さい。

```
# .gitconfig.local の例
[user]
	name  = masa0x80
	email = masa0x80@gmail.com
```

## Appended Installation

下記コマンドを実行すると、追加で

- redis
- postgresql
- ndenv

などを追加でインストールできます。

`TAGS=append make init`

また `TAGS=git make init` というように特定のツールを指定して実行することもできます。
