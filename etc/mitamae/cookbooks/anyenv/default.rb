include_cookbook 'git'

git_clone "#{node[:env][:home]}/.anyenv" do
  repository 'https://github.com/riywo/anyenv'
end

git_clone "#{node[:env][:home]}/.anyenv/plugins/anyenv-update" do
  repository 'https://github.com/znz/anyenv-update.git'
end

execute 'anyenv init' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    anyenv install --force-init
  EOF
  user node[:user]
  not_if "test -d #{node[:env][:home]}/.config/anyenv/anyenv-install"
end

execute 'anyenv update' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    eval "$(anyenv init - bash)"
    anyenv update
  EOF
  user node[:user]
end
