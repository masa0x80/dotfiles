lazy-load-abbrs() {
  load_file $HOME/.config/zsh/lazy/abbr.zsh
}

add-zsh-hook zshaddhistory lazy-load-abbrs
