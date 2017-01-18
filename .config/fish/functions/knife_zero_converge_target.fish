function knife_zero_converge_target
  __select_target_host | read -l target_host
  test -z $target_host; and return
  echo Converging $target_host...

  knife zero bootstrap $target_host --node-name $target_host --no-converge $argv; \
    and knife zero converge name:$target_host $argv
end
