# ref: http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
tmux_attach_session() {
  if ! is_tmux_running; then
    if shell_has_started_interactively && ! is_ssh_running; then
      if (( $+commands[tmux] )); then
        if tmux has-session >/dev/null 2>&1; then
          tmux list-sessions
          echo -n "Tmux: attach? (y/N/num) "
          read
          if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            tmux attach-session
          elif [[ "$REPLY" =~ ^[Nn]$ ]] || [[ "$REPLY" == '' ]]; then
            return 0
          else
            tmux attach -t "$REPLY"
          fi
        else
          tmux new -s dev
        fi
      fi
    fi
  fi
}
tmux_attach_session
