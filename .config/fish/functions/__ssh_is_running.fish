function __ssh_is_running
    not test -z "$SSH_CONNECTION"
end
