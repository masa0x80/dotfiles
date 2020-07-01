function r -a query
    set -l repo (__ghq_select_repo -q "$query" | string escape -n)
    if test -n "$repo"
        commandline "cd $repo"
        commandline -f execute
    end
    commandline -f repaint
end
