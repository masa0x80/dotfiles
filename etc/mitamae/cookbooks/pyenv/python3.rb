include_cookbook 'pyenv'

execute 'install python3' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    export PYTHON_CONFIGURE_OPTS=#{node[:env][:python_configure_opts]}
    eval "$(anyenv init - bash)"
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q #{node[:python][:version3]} || pyenv install #{node[:python][:version3]}
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q "* #{node[:python][:version3]}" || pyenv global #{node[:python][:version2]} #{node[:python][:version3]}
  EOF
  user node[:user]
end
