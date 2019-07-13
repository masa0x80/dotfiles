include_cookbook 'anyenv'

execute 'install pyenv' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    anyenv install pyenv
  EOF
  user node[:user]
  not_if "test -d #{node[:env][:home]}/.anyenv/envs/pyenv"
end

execute 'fix python2 version' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    pip install --upgrade pip
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q #{node[:python][:version2]} || pyenv install #{node[:python][:version2]}
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep -q "* #{node[:python][:version2]}" || pyenv global #{node[:python][:version2]}
  EOF
  user node[:user]
end
