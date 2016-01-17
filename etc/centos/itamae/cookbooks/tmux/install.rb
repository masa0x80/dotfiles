%w[
  libevent
  libevent-devel
  libevent-headers
].each do |name|
  package name do
    action :remove
    user   'root'
  end
end

%w[
  libevent-devel
].each do |name|
  package name do
    action  :install
    options '--enablerepo=remi'
    user    'root'
  end
end

%w[
  gcc-c++
  openssl
  openssl-devel
  ncurses-devel
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'download tmux' do
  command "cd #{node[:src_dir]} && curl -LO https://github.com/tmux/tmux/releases/download/#{node[:version][:tmux]}/tmux-#{node[:version][:tmux]}.tar.gz"
  not_if 'type -a tmux'
end

execute 'unarchive tmux' do
  command "cd #{node[:src_dir]} && tar zxf tmux-#{node[:version][:tmux]}.tar.gz"
  not_if 'type -a tmux'
end

execute 'install tmux' do
  command "cd #{node[:src_dir]}/tmux-#{node[:version][:tmux]} && ./configure && make && sudo make install"
  not_if 'type -a tmux'
end
