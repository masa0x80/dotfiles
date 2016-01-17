execute 'install ndenv' do
  command 'anyenv install ndenv'
  not_if  'type -a ndenv'
end

execute 'fix node.js version' do
  command "zsh -lc 'ndenv install #{node[:version][:nodejs]} && ndenv global #{node[:version][:nodejs]}'"
  not_if  "type -a ndenv && ndenv versions | grep #{node[:version][:nodejs]}"
end
