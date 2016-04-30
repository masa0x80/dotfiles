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
sh -lc 'brew update'
# Upgrade formula
sh -lc 'brew upgrade'

# Install tools
sh -lc 'brew file install'
sh -lc 'brew cask cleanup'
