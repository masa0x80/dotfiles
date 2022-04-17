_rename-tmux() {
  if [ ! -z "$TMUX" -a -z "$VIM" ]; then
    tmux rename-window $(current_dir)
  fi
}
add-zsh-hook precmd _rename-tmux
