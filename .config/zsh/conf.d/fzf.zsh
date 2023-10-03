#
# fzf
#

if (( ${+commands[fzf]} )); then
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-u:page-up,ctrl-d:page-down,ctrl-j:preview-down,ctrl-k:preview-up,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#333333,hl:#5f87af --color=fg+:#d0d0d0,bg+:#262626,hl+:#61afef --color=info:#afaf87,prompt:#e06c75,pointer:#e5c07b --color=marker:#98c379,spinner:#aab2bf,header:#87afaf'

  if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
    export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
    FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
  fi

  if (( ${+commands[bat]} )); then
    export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}'"
  fi

  if [ -n "$TMUX" ]; then
    export FZF_TMUX_OPTS="-p 80% --border none"
    alias fzf="fzf-tmux ${FZF_TMUX_OPTS-}"
  fi

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

  # history with fzf
  # ref: http://blog.kenjiskywalker.org/blog/2014/06/12/peco
  # ref: http://qiita.com/uchiko/items/f6b1528d7362c9310da0
  history-fzf() {
    BUFFER=$(\history -n 1 | \
      fzf +m --no-sort --tac --query "$LBUFFER")
    CURSOR=$#BUFFER
    [ -z "$BUFFER" ] && return 0
    zle clear-screen
  }
  zle -N history-fzf
  bindkey '^R' history-fzf
fi
