case node[:platform]
when 'darwin'
  # Install rust via brew bundle
when 'redhat'
  execute 'install rust' do
    command 'curl https://sh.rustup.rs -s -o /tmp/rustup.sh; chmod +x /tmp/rustup.sh; /tmp/rustup.sh -y'
    user node[:user]
    not_if "test -f #{node[:env][:cargo_home]}/bin/rustc"
  end
end

%w[
  bat
  exa
  fd-find
  ripgrep
].each do |pkg|
  execute "cargo install #{pkg}" do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:env][:path]}
      cargo install --force #{pkg}
    EOF
    user node[:user]
  end
end
