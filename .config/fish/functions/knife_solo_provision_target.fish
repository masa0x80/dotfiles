function knife_solo_provision_target
  select_target_host | read -l target_host; \
        and krepare $target_host; \
        and kook $target_host
end
