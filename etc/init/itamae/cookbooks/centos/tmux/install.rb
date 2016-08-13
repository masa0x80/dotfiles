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

libevent_packages = %w[
  libevent-devel
]

case node[:os_version]
when :centos6_7
  libevent_packages = %w[
    libevent-last-devel
  ]
end
libevent_packages.each do |name|
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
  command "cd #{node[:src_dir]} && curl -LO https://github.com/tmux/tmux/releases/download/#{node[:tmux][:version]}/tmux-#{node[:tmux][:version]}.tar.gz"
  not_if  'type -a tmux'
end

execute 'unarchive tmux' do
  command "cd #{node[:src_dir]} && tar zxf tmux-#{node[:tmux][:version]}.tar.gz"
  not_if  'type -a tmux'
end

execute 'install tmux' do
  command "cd #{node[:src_dir]}/tmux-#{node[:tmux][:version]} && ./configure && make && sudo make install"
  not_if  'type -a tmux'
end
