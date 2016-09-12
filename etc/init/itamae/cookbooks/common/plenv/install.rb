execute 'install plenv' do
  command <<-"EOF"
    source $HOME/.sh_env
    anyenv install plenv
  EOF
  not_if 'type -a plenv'
end

execute 'fix perl version' do
  command <<-"EOF"
    source $HOME/.sh_env
    plenv install #{node[:perl][:version]}
    plenv global  #{node[:perl][:version]}
  EOF
  not_if "type -a plenv && plenv versions | grep #{node[:perl][:version]}"
end
