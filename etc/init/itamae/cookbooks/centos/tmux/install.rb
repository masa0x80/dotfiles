%w(
  libevent
  libevent-devel
  libevent-headers
).each do |name|
  package name do
    action :remove
    user   'root'
  end
end

package 'libevent-devel' do
  action  :install
  options '--enablerepo=remi'
  user    'root'
end

%w(
  gcc-c++
  openssl
  openssl-devel
  ncurses-devel
).each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'install tmux' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://github.com/tmux/tmux/releases/download/#{node[:tmux][:version]}/tmux-#{node[:tmux][:version]}.tar.gz
    tar zxf tmux-#{node[:tmux][:version]}.tar.gz
    cd #{node[:src_dir]}/tmux-#{node[:tmux][:version]}
    ./configure && make && sudo make install
  EOF
  not_if 'type -a tmux'
end
