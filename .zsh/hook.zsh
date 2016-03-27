is_tmux_running() {
  [ ! -z "$TMUX" ]
}

rename_window() {
  if is_tmux_running; then
    if [ -e .git ]; then
      tmux rename-window "$PWD:h:t/$PWD:t"
    fi
  fi
}
autoload -Uz add-zsh-hook
PERIOD=1
add-zsh-hook periodic rename_window
