function ssh
  if set -q $DISABLE_ASSH
    command ssh $argv
    return
  end

  set -l window_name (tmux display -p '#{window_name}')
  if type -qa assh; and test -f $HOME/.ssh/assh.yml
    assh wrapper ssh $argv
  else
    command ssh $argv
  end
  tmux rename-window $window_name
end
