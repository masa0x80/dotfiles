include_cookbook 'git'
include_cookbook 'anyenv'

execute 'install ndenv' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    anyenv install ndenv
  EOF
  user node[:user]
  not_if "test -d #{node[:home]}/.anyenv/envs/ndenv"
end

git_clone "#{node[:home]}/.anyenv/envs/ndenv/plugins/ndenv-default-npms" do
  repository 'https://github.com/kaave/ndenv-default-npms.git'
end

file "#{node[:home]}/.anyenv/envs/ndenv/default-npms" do
  content "yarn\n"
  owner node[:user]
end

execute 'fix node version' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    type -a ndenv > /dev/null 2>&1 && ndenv versions | grep #{node[:nodejs][:version]} || ndenv install #{node[:nodejs][:version]}
    ndenv global  #{node[:nodejs][:version]}
  EOF
  user node[:user]
end
