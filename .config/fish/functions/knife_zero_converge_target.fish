function knife_zero_converge_target
  __select_target_host | read -l target_host
  set -q target_host; and return

  commandline "knife zero bootstrap $target_host --node-name $target_host --no-converge $argv; \
    and knife zero converge name:$target_host $argv"
  __execute_wrapper
end
