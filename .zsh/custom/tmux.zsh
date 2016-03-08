function is_tmux_running() { [ ! -z "$TMUX" ]; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_attach_session() {
  if ! is_tmux_running; then
    if shell_has_started_interactively && ! is_ssh_running; then
      if (( $+commands[tmux] )); then
        if tmux has-session >/dev/null 2>&1; then
          tmux attach-session
        else
          tmux
        fi
      fi
    fi
  fi
}
tmux_attach_session
