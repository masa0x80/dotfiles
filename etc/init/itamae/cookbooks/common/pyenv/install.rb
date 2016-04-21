execute 'install pyenv' do
  command 'anyenv install pyenv'
  not_if 'type -a pyenv'
end

execute 'fix python2 version' do
  command "zsh -lc 'pyenv install #{node[:python][:version2]} && pyenv global #{node[:python][:version2]}'"
  not_if  "type -a pyenv && pyenv versions | grep #{node[:python][:version2]}"
end
