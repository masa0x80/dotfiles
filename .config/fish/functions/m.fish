function m
    if type -qa tldr
        tldr $argv
    end
    if test $status = 1
        man $argv
    end
end
