execute 'install jo' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://github.com/jpmens/jo/releases/download/v#{node[:jo][:version]}/jo-#{node[:jo][:version]}.tar.gz
    tar zxf jo-#{node[:jo][:version]}.tar.gz
    cd #{node[:src_dir]}/jo-#{node[:jo][:version]}
    ./configure
    make check
    sudo make install
  EOF
  not_if "zsh -lc 'type -a jo'"
end
