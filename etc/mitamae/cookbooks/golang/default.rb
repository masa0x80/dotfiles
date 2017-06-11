case node[:platform]
when 'darwin'
  package 'go'
when 'redhat'
  execute 'remove go' do
    command '[ -e /usr/local/go ] && rm -rf /usr/local/go'
    only_if "type -a go  > /dev/null 2>&1 && go version | grep -v #{node[:golang][:version]}"
  end

  execute 'install go' do
    command <<-"EOF"
      curl -LO https://storage.googleapis.com/golang/go#{node[:golang][:version]}.linux-amd64.tar.gz
      tar -C /usr/local -xzf go#{node[:golang][:version]}.linux-amd64.tar.gz
    EOF
    cwd node[:src_dir]
    not_if 'type -a go > /dev/null 2>&1'
  end
end

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
