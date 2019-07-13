include_cookbook 'pyenv'

execute 'install python3' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    export PYTHON_CONFIGURE_OPTS=#{node[:env][:python_configure_opts]}
    eval "$(anyenv init - bash)"
    pip3 install --upgrade pip
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q #{node[:python][:version3]} || pyenv install #{node[:python][:version3]}
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q "* #{node[:python][:version3]}" || pyenv global #{node[:python][:version2]} #{node[:python][:version3]}
  EOF
  user node[:user]
end

include_cookbook 'awscli'
include_cookbook 'httpie'
include_cookbook 's3cmd'
include_cookbook 'yq'

include_cookbook 'mycli'
include_cookbook 'pgcli'

include_cookbook 'neovim' do
  recipe 'pip_neovim'
end
