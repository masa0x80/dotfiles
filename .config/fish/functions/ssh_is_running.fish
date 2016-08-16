function ssh_is_running
  not test -z "$SSH_CONNECTION"
end
