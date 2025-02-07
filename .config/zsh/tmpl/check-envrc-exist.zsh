check-envrc-exist() {
  if [ -f "${PWD:q}/.envrc" -a -f mise.toml -a ! $(grep -q '\[env\]' mise.toml >/dev/null 2>&1) ]; then
    echo -e '\n\033[7;36m[WARN] [env] is not found in mise.toml.\033[0;39m'
  fi
}
add-zsh-hook precmd check-envrc-exist
