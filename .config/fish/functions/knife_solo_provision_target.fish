function knife_solo_provision_target
  __select_target_host | read -l target_host
  set -q target_host; or return

  commandline "knife solo prepare $target_host $argv; \
    and knife solo cook $target_host $argv"
  __execute_wrapper
end
