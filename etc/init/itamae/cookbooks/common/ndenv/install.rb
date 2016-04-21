execute 'install ndenv' do
  command 'anyenv install ndenv'
  not_if  'type -a ndenv'
end

execute 'fix node.js version' do
  command "zsh -lc 'ndenv install #{node[:nodejs][:version]} && ndenv global #{node[:nodejs][:version]}'"
  not_if  "type -a ndenv && ndenv versions | grep #{node[:nodejs][:version]}"
end
