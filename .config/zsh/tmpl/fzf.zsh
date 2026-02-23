#
# fzf
#

if (( ${+commands[fzf]} )); then
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-u:page-up,ctrl-d:page-down,ctrl-j:preview-down,ctrl-k:preview-up,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
      --color=spinner:#F5E0DC,hl:#F38BA8 \
      --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
      --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
      --color=selected-bg:#45475A \
      --color=border:#6C7086,label:#CDD6F4"

  if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
    export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
    FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
  fi

  if (( ${+commands[bat]} )); then
    export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}'"
  fi

  # if [ -n "$TMUX" ]; then
  #   export FZF_TMUX_OPTS="-p 80% --border none"
  #   alias fzf="fzf-tmux ${FZF_TMUX_OPTS-}"
  # fi

  if (( ${+commands[fd]} && ${+commands[bat]} )); then
    # CTRL-T - Paste the selected file path(s) into the command line
    __fsel() {
      local cmd="${FZF_CTRL_T_COMMAND}"
      setopt localoptions pipefail no_aliases 2> /dev/null
      local item
      eval "$cmd" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_CTRL_T_OPTS-}" fzf -m | while read item; do
        echo -n "${(q)item} "
      done
      local ret=$?
      echo
      return $ret
    }

    fzf-file-widget() {
      LBUFFER="${LBUFFER}$(__fsel)"
      local ret=$?
      zle reset-prompt
      return $ret
    }

    # ALT-C - cd into the selected directory
    fzf-cd-widget() {
      local cmd="${FZF_ALT_C_COMMAND}"
      setopt localoptions pipefail no_aliases 2> /dev/null
      local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-}" fzf +m)"
      if [[ "$dir" = '' ]]; then
        zle reset-prompt
        return 0
      fi
      LBUFFER="${LBUFFER}${(q)dir}"
      local ret=$?
      zle reset-prompt
      return $ret
    }

    fzf-t-widget() {
      if test "$LBUFFER" = "cd "; then
        fzf-cd-widget
      else
        fzf-file-widget
      fi
    }
    zle -N fzf-t-widget
    bindkey '^T' fzf-t-widget
  fi
fi
