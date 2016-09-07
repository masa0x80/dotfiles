execute 'remove go' do
  command '[ -e /usr/local/go ] && sudo rm -r /usr/local/go'
  only_if "zsh -lc 'type -a go && go version | grep -v #{node[:golang][:version]}'"
end

execute 'install go' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://storage.googleapis.com/golang/go#{node[:golang][:version]}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go#{node[:golang][:version]}.linux-amd64.tar.gz
  EOF
  not_if "zsh -lc 'type -a go'"
end
