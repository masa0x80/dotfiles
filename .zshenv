# Global Environment Variables {{{

export UNAME_S=$(uname -s | tr '[:upper:]' '[:lower:]')

# NOTE: must place after setting UNAME_S
source $HOME/.common_variables

# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=$(which zsh)

# }}}

# anyenv settings
[ -d $HOME/.anyenv ] && PATH=$HOME/.anyenv/bin:$PATH
if type -a anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# golang
if test -d $HOME/.go; then
  export GOPATH=$HOME/.go
  PATH=$GOPATH/bin:$PATH
  [ $UNAME_S = 'linux' ] && PATH=/usr/local/go/bin:$PATH
fi

# EDITOR
if (( $+commands[nvim] )); then
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  export EDITOR=vim
fi

# PAGER
(( $+commands[less] )) && export PAGER=less

# Configurations for zsh {{{

# NOTE: Do not load global rc files
setopt no_global_rcs

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# zplug
export ZPLUG_HOME=$HOME/.zplug

# NOTE: Create zsh compiled files
() {
  local src
  for src in $@; do
    ([[ ! -e $src.zwc ]] || [ ${src:A} -nt $src ]) && zcompile $src
  done
} $HOME/.zshenv `find $ZDOTDIR -type f -name '*.zsh'`

# }}}
