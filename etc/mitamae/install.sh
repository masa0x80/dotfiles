#!/bin/sh

bin/setup

case $(uname) in
  Darwin) bin/mitamae local bootstrap.rb ;;
  *) sudo -E bin/mitamae local bootstrap.rb ;;
esac
