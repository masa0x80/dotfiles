export SHELL=/bin/bash

# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

# Source environment
test -r $HOME/.sh_env && source $HOME/.sh_env

# start fish
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  SHELL=`which fish`
  test -x "${SHELL}" && exec "${SHELL}" -l
fi
