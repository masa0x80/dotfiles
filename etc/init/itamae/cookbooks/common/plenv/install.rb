execute 'install plenv' do
  command 'anyenv install plenv'
  not_if  'type -a plenv'
end

execute 'fix perl version' do
  command <<-"EOF"
    zsh -lc 'plenv install #{node[:perl][:version]}'
    zsh -lc 'plenv global  #{node[:perl][:version]}'
  EOF
  not_if "type -a plenv && plenv versions | grep #{node[:perl][:version]}"
end
