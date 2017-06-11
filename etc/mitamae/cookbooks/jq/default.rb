case node[:platform]
when 'darwin'
  # Install jq via brew bundle
when 'redhat'
  execute 'install jq' do
    command <<-"EOF"
      cd #{node[:src_dir]}
      curl -LO https://stedolan.github.io/jq/download/linux64/jq
      chmod +x jq
      mv #{node[:src_dir]}/jq #{node[:bin_dir]}/
    EOF
    not_if 'type -a jq > /dev/null 2>&1'
  end
end
