function r -a query
    set -l repo "$(__ghq_select_repo -q "$query" | string escape -n)"
    if test "$repo" != ""
        cd "$repo"
    end
end
