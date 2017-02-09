include_cookbook 'anyenv'

execute 'install plenv' do
  command <<-"EOF"
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    anyenv install plenv
  EOF
  user node[:user]
  not_if "test -d #{node[:home]}/.anyenv/envs/plenv"
end

execute 'fix perl version' do
  command <<-"EOF"
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    type -a plenv > /dev/null 2>&1 && plenv versions | grep #{node[:perl][:version]} || plenv install #{node[:perl][:version]}
    plenv global  #{node[:perl][:version]}
  EOF
  user node[:user]
end
