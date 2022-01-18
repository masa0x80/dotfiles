# NOTE: must place after adding `/usr/local/bin` to PATH
export SHELL=$(which zsh)

# Configurations for zsh {{{

# NOTE: Do not load global rc files
setopt no_global_rcs

# homebrew
if test -e /opt/homebrew/bin/brew; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
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
