function vi
    if type -qa neovide
        neovide $argv
    else
        eval $EDITOR (string unescape -- $argv | string escape -n)
    end
end
