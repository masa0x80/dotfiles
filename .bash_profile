export SHELL=/bin/bash

# Loading global definitions
test -r /etc/bashrc && source /etc/bashrc

# Loading environment variables
test -r $HOME/.environments && source $HOME/.environments

SHELL=`which fish`

# NOTE: Preloading anyenv settings and environment variables especially for fish-shell before invoking shell
[[ $SHELL =~ .*fish ]] && export _PATH=$PATH

# Invoke $SHELL
exec "$SHELL" -l
