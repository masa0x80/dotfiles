function kdb -a cmd query
    if test \( "$cmd" != 'show' \) -a \( "$cmd" != 'edit' \)
        set cmd 'show'
        set query $argv
    end
    find data_bags -path '**/*.json' | sed -e 's/^data_bags\///' | sed -e 's/\// /' | sed -e 's/\.json$//' | fzf --query "$query" | read -l data_bag_name
    set -q data_bag_name
    or return

    echo "knife data bag $cmd $data_bag_name" | read -l cmd
    commandline $cmd
end
