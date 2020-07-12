# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS%20)](#installation)

## Overview

Install dotfiles and useful commands.

## Installation

```
git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

Optional Steps:

Install Mac App Store's apps.

```sh
make brew-mas
```

Upgrade cask apps.

```sh
make brew-cask-upgrade
```

Update golang tools.

```sh
make golang-update
```

Update rust tools.

```sh
make rust-update
```

## After Installation

### Git Config

After installation, make your personal configuration file for git.

```
$ mkdir -p $HOME/.config.local/git
$ cat <<EOF > $HOME/.config.local/git/config
[user]
  name  = masa0x80
  email = masa0x80@gmail.com
[core]
  hooksPath = ~/.config.local/git/hooks
[url "git@github.com:"]
  insteadOf = https://github.com/
EOF
```

ref. https://github.com/masa0x80/dotfiles.local

### Terminal Color

Load `./etc/data/terminal/iceberg.itermcolors` for **Terminal.app** profile.
