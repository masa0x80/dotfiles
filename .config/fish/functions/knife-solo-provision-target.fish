function knife-solo-provision-vagrant
  select-target-host | read -l target_host; vagrant destroy -f && vagrant up && krepare $target_host && kook $target_host
end
