# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS%20)](#installation)

## Installation

好きなところにCloneして `make` を実行すると、`mise bootstrap` で `$HOME` 配下にシンボリックリンクを張り、各種ツールのインストールとmacOSの設定を行います。
設定内容はリポジトリー直下の `mise.toml` に宣言しています。

```sh
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

デフォルトではGitの設定が行われません。  
下記要領でファイルを準備して名前やメールアドレスの設定を行ってください。

```sh
$ mkdir -p $HOME/.config.local/git
$ cat <<EOF >$HOME/.config.local/git/config
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

### ローカル設定も込みでセットアップ

ローカル設定用のリポジトリーをあらかじめCloneして、make時に指定するとローカル設定も込でセットアップできます。
`$DOTFILES_LOCAL_DIR/mise.local.toml` が `mise.local.toml` としてコピーされ、`mise.toml` に重ねて適用されます。

```sh
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make DOTFILES_LOCAL_DIR=~/.dotfiles.local
```

## Update packages

```sh
# パッケージの更新も含めて適用
make bootstrap

# mise.toml から外したHomebrewのパッケージを削除
make brew-prune
```
