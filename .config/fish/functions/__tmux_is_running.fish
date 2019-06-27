function __tmux_is_running
    type -qa tmux && test -n "$TMUX"
end
