autoload -Uz add-zsh-hook

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/=-]}

setopt auto_cd
setopt auto_pushd
setopt auto_param_slash
setopt auto_menu
setopt cd_silent
setopt pushd_ignore_dups
setopt list_packed
setopt list_types
setopt auto_list
setopt magic_equal_subst
setopt brace_ccl
setopt nolistbeep
setopt extended_glob
setopt interactive_comments
setopt long_list_jobs
setopt no_bg_nice
setopt no_check_jobs
setopt no_hup

setopt correct

bindkey -e

if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=30000
SAVEHIST=30000

setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt share_history

autoload -Uz url-quote-magic

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

installed() {
  (( ${+commands[$1]} ))
}

if_installed() {
  local cmd=$1
  shift
  eval "installed $cmd && $*"
}

# homebrew
cache_file="$ZDOTDIR/cache/brew.zsh"
test -r "$cache_file" || brew shellenv > $cache_file
# Do not apply `zsh-defer`
source $cache_file

path=(
  $HOMEBREW_PREFIX/opt/curl/bin(N-/)
  $HOMEBREW_PREFIX/opt/openssl/bin(N-/)
  $HOMEBREW_PREFIX/opt/sqlite/bin(N-/)
  $HOMEBREW_PREFIX/opt/gettext/bin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-getopt/bin(N-/)
  $HOMEBREW_PREFIX/opt/grep/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/)
  $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin(N-/)
  # golang
  $GOPATH/bin(N-/)
  $path
)
fpath=(
  $ZDOTDIR/functions(N-/)
  $fpath
)

# EDITOR
if installed nvim; then
  export EDITOR=nvim
  alias vi=nvim
elif installed vim; then
  export EDITOR=vim
  alias vi=vim
fi

# ls
if installed eza; then
  alias ls='eza --group-directories-first --icons'
fi

# Pager
if_installed bat export PAGER=bat
# less
export LESS='-RFIX'
# MANPAGER
export MANPAGER='nvim +Man!'

source $ZDOTDIR/sheldon.zsh
