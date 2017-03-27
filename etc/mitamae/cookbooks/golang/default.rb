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
      cd #{node[:src_dir]}
      curl -LO https://storage.googleapis.com/golang/go#{node[:golang][:version]}.linux-amd64.tar.gz
      tar -C /usr/local -xzf go#{node[:golang][:version]}.linux-amd64.tar.gz
    EOF
    not_if 'type -a go > /dev/null 2>&1'
  end
end

node[:golang_repos].each do |repo|
  execute "go get #{repo}"
  user node[:user]
end
