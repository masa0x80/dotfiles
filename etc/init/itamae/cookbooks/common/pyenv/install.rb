execute 'install pyenv' do
  command 'anyenv install pyenv'
  not_if  'type -a pyenv'
end

execute 'fix python2 version' do
  command <<-"EOF"
    zsh -lc 'pyenv install #{node[:python][:version2]}'
    zsh -lc 'pyenv global  #{node[:python][:version2]}'
  EOF
  not_if "zsh -lc 'type -a pyenv && pyenv versions | grep #{node[:python][:version2]}'"
end
