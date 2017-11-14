function open
    if type -qa open
        if count $argv >/dev/null
            command open $argv
        else
            command open .
        end
    end
end
