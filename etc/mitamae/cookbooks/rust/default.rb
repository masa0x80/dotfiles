case node[:platform]
when 'darwin'
when 'redhat'
  execute 'install rust' do
    command 'curl https://sh.rustup.rs -s -o /tmp/rustup.sh; chmod +x /tmp/rustup.sh; /tmp/rustup.sh -y'
    user node[:user]
    not_if 'type -a rustc > /dev/null 2>&1'
  end
end

execute 'cargo install rustfmt' do
  not_if 'type -a rustfmt > /dev/null 2>&1'
end

execute 'cargo install racer' do
  not_if 'type -a racer > /dev/null 2>&1'
end
