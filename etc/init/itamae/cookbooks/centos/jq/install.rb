execute 'install jq' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://stedolan.github.io/jq/download/linux64/jq
    chmod 755 jq
    sudo mv #{node[:src_dir]}/jq #{node[:bin_dir]}/
  EOF
  not_if 'type -a jq'
end
