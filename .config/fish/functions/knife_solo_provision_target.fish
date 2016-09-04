function knife_solo_provision_target
  __select_target_host | read -l target_host; \
        and knife solo prepare $target_host; \
        and knife solo cook $target_host
end
