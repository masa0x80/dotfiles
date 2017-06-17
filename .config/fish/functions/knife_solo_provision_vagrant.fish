function knife_solo_provision_vagrant
  __select_vagrant_host | read -l vagrant_host
  set -q vagrant_host; or return

  commandline "vagrant destroy -f; \
    and vagrant up; \
    and vagrant snapshot save init; \
    and knife solo prepare $vagrant_host $argv; \
    and vagrant snapshot save prepared; \
    and knife solo cook $vagrant_host $argv; \
    and vagrant snapshot save cooked"
  __execute_wrapper
end
