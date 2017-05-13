case node[:platform]
when 'darwin'
when 'redhat'
  execute 'install rust' do
    command 'curl https://sh.rustup.rs -sSf | sh'
    not_if 'type -a rustc > /dev/null 2>&1'
  end
end

execute 'cargo install rustfmt' do
  not_if 'type -a rustfmt > /dev/null 2>&1'
end

execute 'cargo install racer' do
  not_if 'type -a racer > /dev/null 2>&1'
end
