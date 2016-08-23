function knife_solo_provision_vagrant
  select_vagrant_host | read -l vagrant_host; \
        and vagrant destroy -f; \
        and vagrant up; \
        and vagrant snapshot save init; \
        and krepare $vagrant_host; \
        and vagrant snapshot save prepared; \
        and kook $vagrant_host; \
        and vagrant snapshot save cooked
end
