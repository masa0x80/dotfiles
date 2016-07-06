is_tmux_running() {
  [ ! -z "$TMUX" ]
}

shell_has_started_interactively() {
  [ ! -z "$PS1" ]
}

is_ssh_running() {
  [ ! -z "$SSH_CONNECTION" ]
}
