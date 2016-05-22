#!/bin/sh

# Install dependencies
sudo -E yum groupinstall -y 'Development Tools'
sudo -E yum install -y curl git irb python-setuptools ruby

source $HOME/.bash_profile

# Install brew
if type -a brew > /dev/null 2>&1; then
  echo '*** Skip brew install'
else
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)" &>/dev/null </dev/null
fi

# Update homebrew
brew update
# Upgrade formula
brew upgrade

brew install gcc
brew install gdbm
brew install git
brew install libevent
brew install libffi
brew install libxml2
brew install libxslt
brew install ncurses
brew install pcre
brew install readline

brew install autoconf
brew install automake
brew install cmake
brew install coreutils
brew install direnv
brew install fzf
brew install gettext
brew install gibo
brew install global --with-ctags --with-pygments
brew install imagemagick
brew install jo
brew install jq
brew install keychain
brew install libyaml

# brew install lua
# brew install luajit
# brew install mysql
# brew install oniguruma
# brew install openssl
# brew install patchutils
brew install peco

# brew install phantomjs
# brew install postgresql
brew install redis
brew install tmux
brew install the_platinum_searcher
brew install tree

# brew install vim --with-lua --without-python
brew install watch
brew install wget
brew install zsh --without-etcdir

# brew tap neovim/neovim
# brew install neovim --HEAD
