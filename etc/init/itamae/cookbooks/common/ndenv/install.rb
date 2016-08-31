execute 'install ndenv' do
  command <<-"EOF"
    source $HOME/.bash_env
    anyenv install ndenv
  EOF
  not_if 'type -a ndenv'
end

execute 'fix node.js version' do
  command <<-"EOF"
    source $HOME/.bash_env
    ndenv install #{node[:nodejs][:version]}
    ndenv global  #{node[:nodejs][:version]}
  EOF
  not_if "type -a ndenv && ndenv versions | grep #{node[:nodejs][:version]}"
end
