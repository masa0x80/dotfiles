package 'vim' do
  action :remove
  user   'root'
end

%w[
  lua
  lua-devel
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'download vim' do
  command "cd #{node[:src_dir]} && wget ftp://ftp.vim.org/pub/vim/unix/vim-#{node[:vim][:version]}.tar.bz2"
  not_if "ls #{node[:src_dir]}/vim-#{node[:vim][:version]}.tar.bz2"
end

execute 'extract vim' do
  command "cd #{node[:src_dir]} && tar jxf vim-#{node[:vim][:version]}.tar.bz2"
  only_if "ls #{node[:src_dir]}/vim-#{node[:vim][:version]}.tar.bz2"
end

local_ruby_block 'install vim' do
  block do
    `cd #{node[:src_dir]}/vim#{node[:vim][:version].to_s.gsub(/\./, '')} && ./configure #{node[:vim][:make_options]} && make && sudo make install`
  end
  not_if "type -a vim && command vim --version | grep #{node[:vim][:version]}"
end
