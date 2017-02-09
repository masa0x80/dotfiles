include_cookbook 'anyenv'

execute 'install pyenv' do
  command <<-"EOF"
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    anyenv install pyenv
  EOF
  user node[:user]
  not_if "test -d #{node[:home]}/.anyenv/envs/pyenv"
end

execute 'fix python2 version' do
  command <<-"EOF"
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep #{node[:python][:version2]} || pyenv install #{node[:python][:version2]}
    pyenv global #{node[:python][:version2]}
  EOF
  user node[:user]
end
