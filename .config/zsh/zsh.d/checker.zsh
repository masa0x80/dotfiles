check-envrc-exist() {
  if [ -f "${PWD:q}/.envrc" -a -f mise.toml -a ! $(grep -q '\[env\]' mise.toml >/dev/null 2>&1) ]; then
    echo -e '\n\033[7;36m[WARN] [env] is not found in mise.toml.\033[0;39m'
  fi
}
add-zsh-hook chpwd check-envrc-exist

check-local-git-config() {
  if [ ! -f $HOME/.config.local/git/config ]; then
    echo -e '\n\033[7;36m[WARN] Local git config file is not found. Create ~/.config.local/git/config file.\033[0;39m'
  fi
  add-zsh-hook -d precmd check-local-git-config
}
add-zsh-hook precmd check-local-git-config
