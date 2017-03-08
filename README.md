# Dotfiles

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![macOS | CentOS](https://img.shields.io/badge/platform-macOS%20|%20CentOS-8c8c8c.svg?style=flat-square)](#installation)

## Overview

Install dotfiles and useful commands.

## Installation

### Only CentOS

If you use CentOS, add your account as sudoers in advance.
Do the following 3 steps to change sudoers.

**Step 1:** Open the sudoers file.

```
$ sudo visudo
```

**Step 2:** Comment out the line below.

```
# %wheel  ALL=(ALL)       NOPASSWD: ALL
```

**Step 3:** Run the following command to add the user to the wheel group.

```
$ sudo usermod -G wheel $USER
```

### Common (macOS / CentOS)

In advance, configure the proxy settings as may be necessary.

#### Quick Installation

The easiest way to install this dotfiles is to run the following commmand in terminal.

```
$ curl https://raw.githubusercontent.com/masa0x80/dotfiles/master/etc/install | bash
```

#### Manual Installation

The different way of *Quick Installation* is to run the following commands.

```
$ git clone https://github.com/masa0x80/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make install
```

#### After Installation

After running `make install`, make your personal configuration file for git.

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

### Only macOS

After running `make install`, load `./etc/data/terminal/Hybrid.terminal` for **Terminal.app** profile.

## Structure

### Shell Invocation

`bash` is set as Default shell, but `bash` kick-start `fish` as following steps:

1. Start `bash` after starting termial
2. Read `.bash_profile` at first
3. Read basic environment variables from `.sh_env`
  - Load proxy config if necessary
  - Set PATH
  - Initialize anyenv
  - Set environemnt variables for golang
4. Kick-start `fish`
5. Start or attach `tmux` session by `__tmux_attach_session` function

### Provisioning local machine

`make install` execute the following tasks.

1. `make update`
  - Update dotfiles repository
2. `make init`
  - Install tools by `MItamae`
3. `make deploy`
  - Deploy dotfiles: create symlink to dotfiles under your home directory
