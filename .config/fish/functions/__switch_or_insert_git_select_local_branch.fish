function __switch_or_insert_git_select_local_branch
    set -l buffer (commandline)
    set -l branch (__git_select_branch)
    if test -n "$branch"
        if test -n "$buffer"
            commandline -i "$branch"
        else
            commandline "git switch $branch"
            commandline -f execute
        end
    end
end
