function knife-solo-provision-vagrant
  select-target-host; vagrant destroy -f && vagrant up && krepare $target_host && kook $target_host
end
