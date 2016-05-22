# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

# Linuxbrew
if [[ $OSTYPE != darwin* ]]; then
  export PATH=$HOME/.linuxbrew/bin:$PATH
  export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
  export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
  export HOMEBREW_BUILD_FROM_SOURCE=1
fi

# start zsh
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  ZSH=`which zsh`
  test -x "${ZSH}" && SHELL="${ZSH}" exec "${ZSH}" -l
fi
