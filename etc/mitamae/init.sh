#!/bin/sh

dir_name=$(cd $(dirname $0); pwd)
sh ${dir_name}/bin/setup

case $(uname) in
  Darwin)
    brew update
    brew upgrade
    ${dir_name}/bin/mitamae local bootstrap.rb
    ;;
  *)
    sudo -E ${dir_name}/bin/mitamae local bootstrap.rb
    ;;
esac
