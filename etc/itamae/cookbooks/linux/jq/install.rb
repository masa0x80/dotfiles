execute 'download jq' do
  command "cd #{node[:src_dir]} && curl -LO https://stedolan.github.io/jq/download/linux64/jq"
  not_if  'type -a jq'
end

execute 'deploy jq' do
  command "cd #{node[:src_dir]} && chmod 755 jq && sudo mv #{node[:src_dir]}/jq #{node[:bin_dir]}/"
  not_if  'type -a jq'
end
