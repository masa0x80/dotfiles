#!/bin/bash

mkdir -p $HOME/src

export SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR/..
case `uname` in
  Darwin)
    bash osx/install.sh
    ;;
  Linux)
    bash centos/install.sh
    cd centos/itamae
    source $HOME/.bashrc
    bundle install --path=vendor/bundle
    if [ -z "$TAGS" ]; then
      bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
    else
      TAGS="$TAGS" bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
    fi
    cd ../../../
    ;;
esac

unset SCRIPT_DIR
