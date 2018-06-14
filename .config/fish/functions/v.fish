function v
    if type -qa fzf
        find . -not -path '*/.git/*' | sed -e 's/^\.\///' | fzf --exact --query "$argv" | tr '\n' ' ' | read files
    else
        set files $argv
    end

    if not set -q files
        or test "$files" = ''
        return
    end

    commandline "vi $files"
    commandline -f execute
end
