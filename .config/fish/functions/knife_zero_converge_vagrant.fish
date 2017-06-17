function knife_zero_converge_vagrant
  __select_vagrant_host | read -l vagrant_host
  set -q vagrant_host; or return

  commandline "vagrant destroy -f; \
    and vagrant up; \
    and vagrant snapshot save init; \
    and knife zero bootstrap $vagrant_host --node-name $vagrant_host --no-converge $argv; \
    and vagrant snapshot save prepared; \
    and knife zero converge name:$vagrant_host $argv; \
    and vagrant snapshot save cooked"
  __execute_wrapper
end
