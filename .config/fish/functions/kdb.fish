function kdb
    find data_bags -path '**/*.json' | sed -e 's/^data_bags\///' | sed -e 's/\// /' | sed -e 's/\.json$//' | fzf --query "$argv" | read -l data_bag_name
    set -q data_bag_name
    or return

    echo "knife data bag show $data_bag_name" | read -l cmd
    commandline $cmd
end
