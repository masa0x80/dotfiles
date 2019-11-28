function e
    if type -qa fzf
        fzf -1 -q "$argv" | tr '\n' ' ' | read -l result
        and vi $result
    else
        vi $argv
    end
end
