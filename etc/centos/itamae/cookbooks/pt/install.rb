execute 'download pt' do
  command "cd #{node[:src_dir]} && curl -LO https://github.com/monochromegane/the_platinum_searcher/releases/download/#{node[:version][:pt]}/pt_linux_amd64.tar.gz"
  not_if  'type -a pt'
end

execute 'unarchive pt' do
  command "cd #{node[:src_dir]} && tar zxf #{node[:src_dir]}/pt_linux_amd64.tar.gz"
  not_if  'type -a pt'
end

execute 'deploy pt' do
  command "cd #{node[:src_dir]}/pt_linux_amd64 && chmod 755 pt && sudo mv pt #{node[:bin_dir]}/"
  not_if  'type -a pt'
end
