case node[:platform]
when 'darwin'
  package 'global' do
    options '--with-ctags --with-pygments'
  end
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

  include_cookbook 'pyenv'

  execute 'pip install pygments' do
    command <<-"EOF"
      export PATH=#{node[:home]}/.anyenv/bin:$PATH
      eval "$(anyenv init -)"
      type -a pip > /dev/null 2>&1 && pip list | grep -i pygments || pip install pygments
    EOF
    user node[:user]
  end
end
