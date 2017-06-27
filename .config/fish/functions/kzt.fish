function kzt
    __select_target_host | read -l target_host
    set -q target_host
    or return

    echo "knife zero bootstrap $target_host --node-name $target_host --no-converge $argv; \
    and knife zero converge name:$target_host $argv" | string replace -a -r '\s*;\s+' '; ' | read -l cmd
    commandline $cmd
end
