case node[:platform]
when 'darwin'
  # Install jq via brew bundle
when 'redhat'
  execute 'install jq' do
    command <<-"EOF"
      curl -LO https://stedolan.github.io/jq/download/linux64/jq
      chmod +x jq
      mv jq #{node[:bin_dir]}/bin
    EOF
    cwd node[:src_dir]
    not_if 'type -a jq > /dev/null 2>&1'
  end
end
