# Set fresco config
type -qa ghq && set -U fresco_root (ghq root)
set -U fresco_plugin_list_path $HOME/.config/fish/plugins.fish

if type -qa ghq
    set -l bootstrap_file $fresco_root/github.com/masa0x80/fresco/fresco.fish
    if not test -r $bootstrap_file
        ghq get masa0x80/fresco
    end
    source $bootstrap_file
end
