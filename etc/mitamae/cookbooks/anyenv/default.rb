include_cookbook 'git'

execute 'anyenv update' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init -)"
    anyenv update
  EOF
  user node[:user]
  only_if "test -d #{node[:env][:home]}/.anyenv"
end

git_clone "#{node[:env][:home]}/.anyenv" do
  repository 'https://github.com/riywo/anyenv'
end

git_clone "#{node[:env][:home]}/.anyenv/plugins/anyenv-update" do
  repository 'https://github.com/znz/anyenv-update.git'
end
