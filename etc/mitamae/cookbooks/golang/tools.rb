node[:golang_repos].each do |repo|
  execute "go get #{repo}" do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:env][:path]}
      export GOPATH=#{node[:env][:gopath]}
      go get #{repo}
    EOF
    user node[:user]
    not_if "test -d #{File.join(node[:env][:home], '.go', 'src', repo)}"
  end
end
