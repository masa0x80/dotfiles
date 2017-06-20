function kzv
  __select_vagrant_host | read -l vagrant_host
  set -q vagrant_host; or return

  echo "vagrant destroy -f; \
    and vagrant up; \
    and vagrant snapshot save init; \
    and knife zero bootstrap $vagrant_host --node-name $vagrant_host --no-converge $argv; \
    and vagrant snapshot save prepared; \
    and knife zero converge name:$vagrant_host $argv; \
    and vagrant snapshot save cooked" \
    | string replace -a -r '\s*;\s+' '; ' | read -l cmd
  commandline $cmd
end
