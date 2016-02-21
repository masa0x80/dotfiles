#!/bin/bash

mkdir -p $HOME/src

export SCRIPT_DIR=$(cd $(dirname $0); pwd)

export RUBY_VERSION=2.3.0

cd $SCRIPT_DIR/..
case `uname` in
  Darwin)
    # ref: https://github.com/yyuu/pyenv/wiki/Common-build-problems#build-failed-error-the-python-zlib-extension-was-not-compiled-missing-the-zlib
    export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
    bash darwin/install.sh
    ;;
  Linux)
    bash centos/install.sh
    ;;
esac

cd itamae

# Install anyanv & ruby
if type -a anyenv > /dev/null 2>&1; then
  echo '*** Skip anyenv install'
else
  git clone https://github.com/riywo/anyenv $HOME/.anyenv

  echo ''                                    >> $HOME/.bashrc
  echo '# anyenv settings'                   >> $HOME/.bashrc
  echo 'export PATH=$HOME/.anyenv/bin:$PATH' >> $HOME/.bashrc
  echo 'eval "$(anyenv init -)"'             >> $HOME/.bashrc
  source $HOME/.bashrc
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

  if type -a rbenv > /dev/null 2>&1; then
    echo '*** Skip rbenv install'
  else
    # rbenv configuration
    anyenv install rbenv
    source $HOME/.bashrc
    git clone https://github.com/sstephenson/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems
    echo 'bundler' > $(rbenv root)/default-gems
    rbenv install $RUBY_VERSION
    rbenv global  $RUBY_VERSION
  fi
fi

source $HOME/.bashrc
bundle install --path=vendor/bundle
if [ -z "$TAGS" ]; then
  bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
else
  TAGS="$TAGS" bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
fi
cd ../../

unset RUBY_VERSION
unset SCRIPT_DIR
