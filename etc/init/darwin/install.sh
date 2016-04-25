#!/bin/bash

# Install xcode
if type -a xcode-select > /dev/null 2>&1; then
  echo '*** Skip xcode install'
else
  xcode-select --install
fi

# Prepare to install homebrew
# ref: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Troubleshooting.md
if test -z "$(ls -l /usr/local | grep bin | grep $(whoami))"; then
  if test -e /usr/local; then
    sudo mkdir -p /usr/local
  fi
  sudo chflags norestricted /usr/local && sudo chown -R $(whoami):admin /usr/local
fi

# Install brew-file
if type -a brew-file > /dev/null 2>&1; then
  echo '*** Skip brew-file install'
else
  curl -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh | sh
fi

# Update homebrew
brew update
# Upgrade formula
brew upgrade

# Install tools
sh -lc 'brew file install'

# Solarized for terminal
SOLARIZED_GIT_DIR="$HOME/src/solarized.git"
if ! test -e $SOLARIZED_GIT_DIR; then
  git clone https://github.com/tomislav/osx-terminal.app-colors-solarized $SOLARIZED_GIT_DIR
  echo -e '\033[1;37mEdit terminal.app profile settings.\033[1;37m'
  open $SOLARIZED_GIT_DIR
fi
unset SOLARIZED_GIT_DIR
