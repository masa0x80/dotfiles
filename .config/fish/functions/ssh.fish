function ssh
  set -l window_name (tmux display -p '#{window_name}')
  command ssh $argv
  tmux rename-window $window_name
end
