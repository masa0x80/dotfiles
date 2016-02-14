#!/bin/bash

mkdir -p $HOME/src

export SCRIPT_DIR=$(cd $(dirname $0); pwd)

export RUBY_VERSION=2.3.0

cd $SCRIPT_DIR/..
case `uname` in
  Darwin)
    bash darwin/install.sh
    cd darwin/itamae
    ;;
  Linux)
    bash centos/install.sh
    cd centos/itamae
    ;;
esac

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

  if type -a rbenv > /dev/null 2>&1; then
    echo '*** Skip rbenv install'
  else
    # rbenv configuration
    anyenv install rbenv
    source $HOME/.bashrc
    rbenv install $RUBY_VERSION
    rbenv global  $RUBY_VERSION
    gem install bundler
  fi
fi

source $HOME/.bashrc
bundle install --path=vendor/bundle
if [ -z "$TAGS" ]; then
  bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
else
  TAGS="$TAGS" bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
fi
cd ../../../

unset RUBY_VERSION
unset SCRIPT_DIR
