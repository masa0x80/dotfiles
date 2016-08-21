function knife-solo-provision-vagrant
  select-vagrant-host; vagrant destroy -f && vagrant up && krepare $vagrant_host && kook $vagrant_host
end
