#!/bin/bash

mkdir -p $HOME/src

# 実行ファイルのあるディレクトリーを調べる
abs_dirname() {
  local CWD="$(pwd)"
  local FILE_PATH="$1"

  while [ -n "$FILE_PATH" ]; do
    cd "${FILE_PATH%/*}"
    local NAME="${FILE_PATH##*/}"
    FILE_PATH="$(readlink "$NAME" || true)"
  done

  pwd -P
  cd "$CWD"
}
export SCRIPT_DIR="$(abs_dirname "$0")"

cd $SCRIPT_DIR/..
case `uname` in
  Darwin)
    bash osx/install.sh
    ;;
  Linux)
    bash centos/install.sh
    cd centos/itamae
    bundle install --path=vendor/bundle
    source $HOME/.bashrc
    if [ -z "$TAGS" ]; then
      bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
    else
      bundle exec itamae local entrypoint.rb -y nodes/localhost.yml
    fi
    cd ../../../
    ;;
esac

unset SCRIPT_DIR
