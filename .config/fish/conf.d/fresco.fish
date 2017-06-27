if type -qa ghq
    set -l fresco_file (ghq root)/github.com/masa0x80/fresco/fresco.fish
    if test -r $fresco_file
        source $fresco_file
    else
        ghq get masa0x80/fresco
    end
end
