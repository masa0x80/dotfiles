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
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-e:preview-down,ctrl-y:preview-up,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#333333,hl:#5f87af --color=fg+:#d0d0d0,bg+:#262626,hl+:#61afef --color=info:#afaf87,prompt:#e06c75,pointer:#e5c07b --color=marker:#98c379,spinner:#aab2bf,header:#87afaf'
  export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
fi

if (( ${+commands[bat]} )); then
  export FZF_CTRL_T_OPTS="--preview 'command bat --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

export FZF_TMUX_OPTS="-p 80% --border none"
alias fzf="fzf-tmux $FZF_TMUX_OPTS"
