execute 'install ndenv' do
  command <<-"EOF"
    source $HOME/.sh_env
    anyenv install ndenv
  EOF
  not_if 'type -a ndenv'
end

execute 'install ndenv-default-npms' do
  command <<-"EOF"
    source $HOME/.sh_env
    git clone https://github.com/kaave/ndenv-default-npms.git $(ndenv root)/plugins/ndenv-default-npms
    echo 'yarn' > $(ndenv root)/default-npms
  EOF
  not_if 'test -r $(ndenv root)/default-npms'
end

execute 'fix node.js version' do
  command <<-"EOF"
    source $HOME/.sh_env
    ndenv install #{node[:nodejs][:version]}
    ndenv global  #{node[:nodejs][:version]}
  EOF
  not_if "type -a ndenv && ndenv versions | grep #{node[:nodejs][:version]}"
end
