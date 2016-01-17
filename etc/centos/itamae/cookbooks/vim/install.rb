package 'vim' do
  action :remove
  user   'root'
end

execute "cd #{node[:src_dir]} && wget ftp://ftp.vim.org/pub/vim/unix/vim-#{node[:vim][:version]}.tar.bz2"

execute "cd #{node[:src_dir]} && tar jxf vim-#{node[:vim][:version]}.tar.bz2"

local_ruby_block 'install vim' do
  block do
    `cd #{node[:src_dir]}/vim#{node[:vim][:version].to_s.gsub(/\./, '')} && ./configure #{node[:vim][:make_options]} && make && sudo make install`
  end
end
