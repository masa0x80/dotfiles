case node[:platform]
when 'darwin'
  # Install jo via brew bundle
when 'redhat'
  execute 'download jo' do
    command <<-"EOF"
      curl -LO https://github.com/jpmens/jo/releases/download/v#{node[:jo][:version]}/jo-#{node[:jo][:version]}.tar.gz
      tar zxf jo-#{node[:jo][:version]}.tar.gz
    EOF
    cwd node[:src_dir]
    not_if "test -d #{File.join(node[:src_dir], "jo-#{node[:jo][:version]}")}"
  end

  execute './configure && make check && make install' do
    cwd File.join(node[:src_dir], "jo-#{node[:jo][:version]}")
    not_if 'type -a jo > /dev/null 2>&1'
  end
end
