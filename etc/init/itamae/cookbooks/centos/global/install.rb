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
  not_if "zsh -lc 'type -a global'"
end

include_recipe '../../common/pyenv/install.rb'

execute 'pip install pygments' do
  command "zsh -lc 'pip install pygments'"
  not_if  "zsh -lc 'pip list | grep -i pygments'"
end
