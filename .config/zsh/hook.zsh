check_local_git_config() {
  if [ ! -f $HOME/.config.local/git/config ]; then
    echo -e '\033[7;36m[WARN] Local git config file is not found. Create ~/.config.local/git/config file.'
    echo -e '       Check https://github.com/masa0x80/dotfiles#after-installation\033[0;39m'
  fi
}

autoload -Uz add-zsh-hook
PERIOD=1
add-zsh-hook periodic check_local_git_config
