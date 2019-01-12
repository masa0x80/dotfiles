include_cookbook 'git'
include_cookbook 'anyenv'

execute 'install nodenv' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    anyenv install nodenv
  EOF
  user node[:user]
  not_if "test -d #{node[:env][:home]}/.anyenv/envs/nodenv"
end

git_clone "#{node[:env][:home]}/.anyenv/envs/nodenv/plugins/nodenv-default-packages" do
  repository 'https://github.com/nodenv/nodenv-default-packages'
end

npm_list = <<-EOF
yarn
EOF
file "#{node[:env][:home]}/.anyenv/envs/nodenv/default-packages" do
  content npm_list
  owner node[:user]
end

execute 'fix node version' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    type -a nodenv > /dev/null 2>&1 && nodenv versions | grep #{node[:nodejs][:version]} || nodenv install #{node[:nodejs][:version]}
    nodenv global  #{node[:nodejs][:version]}
  EOF
  user node[:user]
end
