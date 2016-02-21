execute 'download direnv' do
  command "cd #{node[:src_dir]} && curl -Lo direnv https://github.com/zimbatm/direnv/releases/download/#{node[:direnv][:version]}/direnv.linux-amd64"
  not_if  'type -a direnv'
end

execute 'deploy direnv' do
  command "cd #{node[:src_dir]} && chmod 755 direnv && sudo mv direnv #{node[:bin_dir]}/"
  not_if  'type -a direnv'
end
