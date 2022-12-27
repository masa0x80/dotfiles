#
# fzf
#

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
  export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
  _fzf_compgen_path() {
    command fd -c always -H --no-ignore-vcs -E .git -tf . "${1}"
  }
  _fzf_compgen_dir() {
    command fd -c always -H --no-ignore-vcs -E .git -td . "${1}"
  }
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
fi

if (( ${+commands[bat]} )); then
  export FZF_CTRL_T_OPTS="--preview 'command bat --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
