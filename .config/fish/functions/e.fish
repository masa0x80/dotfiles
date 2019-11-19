function e
    if type -qa fzf
        fzf --query "$argv" | tr '\n' ' ' | read -l result
        and vi $result
    else
        vi $argv
    end
end
