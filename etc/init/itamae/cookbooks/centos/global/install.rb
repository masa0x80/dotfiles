execute 'install global' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO http://tamacom.com/global/global-#{node[:global][:version]}.tar.gz
    tar zxf global-#{node[:global][:version]}.tar.gz
    cd #{node[:src_dir]}/global-#{node[:global][:version]}
    ./configure --prefix=/usr/local
    make
    sudo make install
  EOF
  not_if 'type -a global'
end

include_recipe '../../common/pyenv/install.rb'

execute 'pip install pygments' do
  command <<-"EOF"
    source $HOME/.sh_env
    pip install pygments
  EOF
  not_if "source $HOME/.sh_env && pip list | grep -i pygments"
end
