#!/bin/bash

mkdir -p $HOME/src

export SCRIPT_DIR=$(cd $(dirname $0); pwd)
export RUBY_VERSION=`cat $SCRIPT_DIR/../itamae/.ruby-version`

cd $SCRIPT_DIR/..
case `uname` in
  Darwin)
    sh -lc 'bash darwin/install.sh'
    ;;
  Linux)
    sh -lc 'bash centos/install.sh'
    ;;
esac

cd itamae

# Install anyanv & ruby
if type -a anyenv > /dev/null 2>&1; then
  echo '*** Skip anyenv install'
else
  git clone https://github.com/riywo/anyenv $HOME/.anyenv

  source $HOME/.bashrc
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

  # update *env
  anyenv update

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
bundle install --path=vendor/bundle --local
if [ -z "$TAGS" ]; then
  bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
else
  TAGS="$TAGS" bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
fi
cd ../../

unset RUBY_VERSION
unset SCRIPT_DIR
