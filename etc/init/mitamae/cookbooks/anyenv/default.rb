include_cookbook 'git'

execute 'anyenv update' do
  command <<-"EOF"
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    anyenv update
  EOF
  user node[:user]
  only_if "test -d #{node[:home]}/.anyenv"
end

git "#{node[:home]}/.anyenv" do
  repository 'https://github.com/riywo/anyenv'
  user node[:user]
end

git "#{node[:home]}/.anyenv/plugins/anyenv-update" do
  repository 'https://github.com/znz/anyenv-update.git'
  user node[:user]
end
