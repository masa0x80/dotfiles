function e
    if type -qa fzf
        fzf -1 -q "$argv" | tr '\n' ' ' | read -l result
        and eval $EDITOR $result
    else
        eval $EDITOR $argv
    end
end
