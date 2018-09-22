include_cookbook 'anyenv'

execute 'install rbenv' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init -)"
    anyenv install rbenv
  EOF
  user node[:user]
  not_if "test -d #{node[:env][:home]}/.anyenv/envs/rbenv"
end

git_clone "#{node[:env][:home]}/.anyenv/envs/rbenv/plugins/rbenv-default-gems" do
  repository 'https://github.com/sstephenson/rbenv-default-gems.git'
end

gem_list = <<-EOF
bundler
rails
foreman
pry
jr
EOF
file "#{node[:env][:home]}/.anyenv/envs/rbenv/default-gems" do
  content gem_list
  owner node[:user]
end

execute 'fix ruby version' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init -)"
    type -a rbenv > /dev/null 2>&1 && rbenv versions | grep #{node[:ruby][:version]} || rbenv install #{node[:ruby][:version]}
    rbenv global  #{node[:ruby][:version]}
  EOF
  user node[:user]
end
