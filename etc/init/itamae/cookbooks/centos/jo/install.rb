execute 'download jo' do
  command "cd #{node[:src_dir]} && curl -LO https://github.com/jpmens/jo/releases/download/v#{node[:jo][:version]}/jo-#{node[:jo][:version]}.tar.gz"
  not_if  "zsh -lc 'type -a jo'"
end

execute 'unarchive jo' do
  command "cd #{node[:src_dir]} && tar zxf jo-#{node[:jo][:version]}.tar.gz"
  not_if  "zsh -lc 'type -a jo'"
end

execute 'install global' do
  command "cd #{node[:src_dir]}/jo-#{node[:jo][:version]} && ./configure && make check && sudo make install"
  not_if  "zsh -lc 'type -a jo'"
end
