execute 'download peco' do
  command "cd #{node[:src_dir]} && curl -LO https://github.com/peco/peco/releases/download/#{node[:peco][:version]}/peco_linux_amd64.tar.gz"
  not_if  'type -a peco'
end

execute 'unarchive peco' do
  command "cd #{node[:src_dir]} && tar zxf #{node[:src_dir]}/peco_linux_amd64.tar.gz"
  not_if  'type -a peco'
end

execute 'deploy peco' do
  command "cd #{node[:src_dir]}/peco_linux_amd64 && chmod 755 peco && sudo mv peco #{node[:bin_dir]}/"
  not_if  'type -a peco'
end
