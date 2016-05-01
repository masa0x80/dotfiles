execute 'download global' do
  command "cd #{node[:src_dir]} && curl -LO http://tamacom.com/global/global-#{node[:global][:version]}.tar.gz"
end

execute 'unarchive global' do
  command "cd #{node[:src_dir]} && tar zxf global-#{node[:global][:version]}.tar.gz"
end

execute 'install global' do
  command "cd #{node[:src_dir]}/global-#{node[:global][:version]} && ./configure --prefix=/usr/local && make && sudo make install"
end

include_recipe '../../common/pyenv/install.rb'

execute 'pip install pygments' do
  command "zsh -lc 'pip install pygments'"
  not_if  "zsh -lc 'pip list | grep pygments'"
end
