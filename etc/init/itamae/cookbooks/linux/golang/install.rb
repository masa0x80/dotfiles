execute 'remove go' do
  command "[ -e /usr/local/go ] && sudo rm /usr/local/go"
  only_if 'type -a go'
end

execute 'download go' do
  command "cd #{node[:src_dir]} && curl -LO https://storage.googleapis.com/golang/go#{node[:golang][:version]}.linux-amd64.tar.gz"
  not_if 'type -a go'
end

execute 'unarchive go' do
  command "cd #{node[:src_dir]} && sudo tar -C /usr/local -xzf go#{node[:golang][:version]}.linux-amd64.tar.gz"
  not_if 'type -a go'
end
