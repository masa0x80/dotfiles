# profiling start
# zmodload zsh/zprof

# Global Environment Variables {{{

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export UNAME_S=$(uname -s | tr '[:upper:]' '[:lower:]')

# }}}

# Configurations for zsh {{{

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# zplug
export ZPLUG_HOME=$HOME/.zplug

() {
  local src
  for src in $@; do
    ([[ ! -e $src.zwc ]] || [ ${src:A} -nt $src ]) && zcompile $src
  done
} $HOME/.zshenv `find $ZDOTDIR -type f -name '*.zsh'`

# }}}
