execute 'install plenv' do
  command 'anyenv install plenv'
  not_if  'type -a plenv'
end

execute 'fix perl version' do
  command "zsh -lc 'plenv install #{node[:perl][:version]} && plenv global #{node[:perl][:version]}'"
  not_if  "type -a plenv && plenv versions | grep #{node[:perl][:version]}"
end
