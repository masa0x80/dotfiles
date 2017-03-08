check_local_git_config() {
  if [ ! -f $HOME/.config.local/git/config ]; then
    echo -e '\033[7;36m[WARN] Local git config file is not found. Create ~/.config.local/git/config file.'
    echo -e '       Check https://github.com/masa0x80/dotfiles#after-installation\033[0;39m'
  fi
}

rename_window() {
  check_local_git_config
  if is_tmux_running; then
    if [ -e .git ]; then
      tmux rename-window "$PWD:h:t/$PWD:t"
    fi
  fi
}
autoload -Uz add-zsh-hook
PERIOD=1
add-zsh-hook periodic rename_window
