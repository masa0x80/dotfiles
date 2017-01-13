function knife_solo_provision_vagrant
  __select_vagrant_host | read -l vagrant_host; \
        and vagrant destroy -f; \
        and vagrant up; \
        and vagrant snapshot save init; \
        and knife solo prepare vagrant@$vagrant_host; \
        and vagrant snapshot save prepared; \
        and knife solo cook vagrant@$vagrant_host; \
        and vagrant snapshot save cooked
end
