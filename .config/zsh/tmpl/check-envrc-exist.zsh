check-envrc-exist() {
  if [ -f $(pwd)/.envrc ]; then
    if [ ! $(grep -q '\[env\]' mise.toml >/dev/null 2>&1) ]; then
      echo -e '\n\033[7;36m[WARN] .envrc is found.\033[0;39m'
    fi
  fi
}
add-zsh-hook precmd check-envrc-exist
