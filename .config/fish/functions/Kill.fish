function Kill
    set -l pids (ps -e -o pid,comm | fzf --query "$argv" | awk '{print $1}')
    if test "$pids" != ''
        echo $pids | xargs kill -9
    end
end
