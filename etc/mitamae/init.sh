#!/bin/sh

dir_name=$(cd $(dirname $0); pwd)
sh ${dir_name}/bin/setup

case $(uname) in
  Darwin)
    if type -a xcode-select > /dev/null 2>&1; then
      echo ' SKIP : xcode-select installation'
    else
      xcode-select --install
    fi
    ${dir_name}/bin/mitamae local bootstrap.rb
    ;;
  *)
    sudo -E ${dir_name}/bin/mitamae local bootstrap.rb
    ;;
esac
