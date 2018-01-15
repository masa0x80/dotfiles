if type -qa ghq
    set -l bootstrap_file (ghq root)/github.com/masa0x80/fresco/fresco.fish
    if test -r $bootstrap_file
        source $bootstrap_file
    else
        ghq get masa0x80/fresco
    end
end
