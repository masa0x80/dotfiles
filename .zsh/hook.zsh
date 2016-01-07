function is_tmux_runnning() {
  [ ! -z "$TMUX" ]
}

function rename_window() {
  if is_tmux_runnning; then
    if [ -e .git ]; then
      tmux rename-window "$PWD:h:t/$PWD:t"
    fi
  fi
}
autoload -Uz add-zsh-hook
PERIOD=1
add-zsh-hook periodic rename_window
