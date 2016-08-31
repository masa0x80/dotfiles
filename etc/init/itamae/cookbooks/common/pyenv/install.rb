execute 'install pyenv' do
  command <<-"EOF"
    source $HOME/.bash_env
    anyenv install pyenv
  EOF
  not_if 'type -a pyenv'
end

execute 'fix python2 version' do
  command <<-"EOF"
    source $HOME/.bash_env
    pyenv install #{node[:python][:version2]}
    pyenv global  #{node[:python][:version2]}
  EOF
  not_if "type -a pyenv && pyenv versions | grep #{node[:python][:version2]}"
end
