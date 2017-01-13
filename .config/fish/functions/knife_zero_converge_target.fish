function knife_zero_converge_target
  __select_target_host | read -l target_host; \
        and knife zero bootstrap $target_host --node-name $target_host --no-converge; \
        and knife zero converge name:$target_host
end
