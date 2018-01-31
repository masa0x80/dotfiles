function ssh
    set -l window_name (tmux display -p '#{window_name}')
    if type -qa sshrc
        sshrc $argv
    else
        command ssh $argv
    end
    tmux rename-window $window_name
end
