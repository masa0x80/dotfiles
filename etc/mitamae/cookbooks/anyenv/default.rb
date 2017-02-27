include_cookbook 'git'

execute 'anyenv update' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    anyenv update
  EOF
  user node[:user]
  only_if "test -d #{node[:home]}/.anyenv"
end

git_clone "#{node[:home]}/.anyenv" do
  repository 'https://github.com/riywo/anyenv'
end

git_clone "#{node[:home]}/.anyenv/plugins/anyenv-update" do
  repository 'https://github.com/znz/anyenv-update.git'
end
