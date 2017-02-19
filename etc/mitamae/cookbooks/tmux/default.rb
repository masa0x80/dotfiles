case node[:platform]
when 'darwin'
  package 'tmux'
when 'redhat'
  %w(
    libevent
    libevent-devel
    libevent-headers
  ).each do |pkg|
    package pkg do
      action :remove
    end
  end

  package 'libevent-devel' do
    options '--enablerepo=remi'
  end

  %w(
    gcc-c++
    openssl
    openssl-devel
    ncurses-devel
  ).each do |pkg|
    package pkg
  end

  execute 'download tmux' do
    command <<-"EOF"
      curl -LO https://github.com/tmux/tmux/releases/download/#{node[:tmux][:version]}/tmux-#{node[:tmux][:version]}.tar.gz
      tar zxf tmux-#{node[:tmux][:version]}.tar.gz
    EOF
    cwd node[:src_dir]
    not_if "test -d #{File.join(node[:src_dir], "tmux-#{node[:tmux][:version]}")}"
  end

  execute './configure && make && make install' do
    cwd File.join(node[:src_dir], "tmux-#{node[:tmux][:version]}")
    not_if 'type -a tmux > /dev/null 2>&1'
  end
end
