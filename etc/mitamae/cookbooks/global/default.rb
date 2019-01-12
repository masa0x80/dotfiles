case node[:platform]
when 'darwin'
  # Install global via brew bundle
when 'redhat'
  package 'ncurses-devel'

  execute 'download global' do
    command <<-"EOF"
      curl -LO http://tamacom.com/global/global-#{node[:global][:version]}.tar.gz
      tar zxf global-#{node[:global][:version]}.tar.gz
    EOF
    cwd node[:src_dir]
    not_if "test -d #{File.join(node[:src_dir], "global-#{node[:global][:version]}")}"
  end

  execute "./configure --prefix=#{node[:bin_dir]} && make && make install" do
    cwd File.join(node[:src_dir], "global-#{node[:global][:version]}")
    not_if 'type -a global > /dev/null 2>&1'
  end

  include_cookbook 'pyenv' do
    recipe 'python3'
  end

  pip3 'pygments'
end
