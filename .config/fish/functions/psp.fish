function psp
    commandline "ps -ef | fzf --query '$argv'"
    commandline -f execute
end
