function vi
    eval $EDITOR (string unescape -- $argv | string escape -n)
end
