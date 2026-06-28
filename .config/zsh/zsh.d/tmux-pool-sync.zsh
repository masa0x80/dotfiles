_tmux-pool-sync() {
  if [[ -n "$TMUX" && "$(tmux display-message -p '#S')" != "_pool" ]] && tmux has-session -t _pool 2>/dev/null; then
    tmux send-keys -t _pool " cd \"$PWD\" && clear" Enter
  fi
}
add-zsh-hook chpwd _tmux-pool-sync
