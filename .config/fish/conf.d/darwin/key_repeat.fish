function speed_key_repeat
    # delay until key repeat
    defaults write NSGlobalDomain InitialKeyRepeat -int 10
    # key repeat speed
    defaults write NSGlobalDomain KeyRepeat -int 1
    set_color -o yellow
    echo
    echo You must do logout your mac for taking this effect.
    echo
    set_color normal
end

function reset_key_repeat
    defaults delete NSGlobalDomain KeyRepeat
    defaults delete NSGlobalDomain InitialKeyRepeat
end
