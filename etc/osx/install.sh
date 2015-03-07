#!/bin/bash

if type xcode-select > /dev/null 2>&1; then
  # Homebrewのインストール
  xcode-select --install
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Update homebrew
  brew update
  # Upgrade formula
  brew upgrade

  cd $SCRIPT_DIR/../osx
  brew brewdle

  # cleanup
  brew brewdle cleanup

  # pyenvの設定
  pyenv install 2.7.6
  pyenv global  2.7.6

  # rbenvの設定
  rbenv install 2.2.0
  rbenv global  2.2.0

  # solarized
  git clone https://github.com/tomislav/osx-terminal.app-colors-solarized $HOME/src/solarized.git
  echo 'Edit terminal.app profile settings.'
  open $HOME/src/solarized.git
else
  echo "Error: Install 'Command Line Tools for Xcode'"
fi
