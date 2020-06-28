function e
    if type -qa fzf
        set selected_files (fzf -1 -q "$argv" | string unescape | string escape -n)
        and eval $EDITOR $selected_files
    else
        eval $EDITOR (string escape -n -- $argv)
    end
end
