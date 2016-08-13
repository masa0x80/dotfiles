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
$ mkdir -p $HOME/.private/git
$ cat <<EOF > $HOME/.private/git/config
[user]
  name  = masa0x80
  email = masa0x80@gmail.com
[core]
  hooksPath = ~/.private/git/hooks
[url "git@github.com:"]
  insteadOf = https://github.com/
EOF
```

### Only macOS

After running `make install`, load `./etc/data/terminal/Hybrid.terminal` for **Terminal.app** profile.

## Appendix

### Inside of `make install`

`make install` execute the following tasks.

- `make update`
  - Update dotfiles repository
- `make deploy`
  - Deploy dotfiles
- `make init`
  - Initialize and install tools

Install specified tools instead of running `make init`.

e.g. To install basic tools, run the command below.

```
$ TAGS=basic make init
```

e.g. To install additional tools, run the command below.

```
$ TAGS=addition make init
```

e.g. To install only ndenv, run the command below.

```
$ TAGS=ndenv make init
```

**Note:** `make init` is exactly the same as running `TAGS=basic,additional make init`.
