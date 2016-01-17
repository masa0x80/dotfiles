execute 'install pyenv' do
  command 'anyenv install pyenv'
  not_if 'type -a pyenv'
end

execute 'fix python version' do
  command "zsh -lc 'pyenv install #{node[:python][:version]} && pyenv global #{node[:python][:version]}'"
  not_if  "type -a pyenv && pyenv versions | grep #{node[:python][:version]}"
end
