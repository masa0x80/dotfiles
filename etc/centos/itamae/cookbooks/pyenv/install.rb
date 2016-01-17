execute 'install pyenv' do
  command 'anyenv install pyenv'
  not_if 'type -a pyenv'
end

execute 'fix python version' do
  command "zsh -lc 'pyenv install #{node[:version][:python]} && pyenv global #{node[:version][:python]}'"
  not_if  "type -a pyenv && pyenv versions | grep #{node[:version][:python]}"
end
