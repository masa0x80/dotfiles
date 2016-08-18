function ssh
  set -q $USE_ASSH; and set USE_ASSH false
  if string match $USE_ASSH 'false'
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
