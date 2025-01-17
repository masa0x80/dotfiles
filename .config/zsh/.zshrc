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

source $ZDOTDIR/sheldon.zsh
