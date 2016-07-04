is_tmux_running() {
  [ ! -z "$TMUX" ]
}

check_private_git_config() {
  if [ ! -f $HOME/.private/git/config ]; then
    echo -e '\033[7;36m[WARN] Private git config file is not found.\033[0;39m'
  fi
}

rename_window() {
  check_private_git_config
  if is_tmux_running; then
    if [ -e .git ]; then
      tmux rename-window "$PWD:h:t/$PWD:t"
    fi
  fi
}
autoload -Uz add-zsh-hook
PERIOD=1
add-zsh-hook periodic rename_window
