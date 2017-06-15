node[:golang_repos].each do |repo|
  execute "go get #{repo}" do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:env][:path]}
      export GOPATH=#{node[:env][:gopath]}
      go get #{repo}
    EOF
    user node[:user]
  end
end
