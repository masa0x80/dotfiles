case node[:platform]
when 'darwin'
  # Install phantomjs via brew bundle
when 'redhat'
  execute 'install phantomjs' do
    command <<-"EOF"
      curl -LO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2
      tar jxf phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2
      cp phantomjs-#{node[:phantomjs][:version]}-linux-x86_64/bin/phantomjs #{node[:bin_dir]}
    EOF
    cwd node[:src_dir]
    not_if 'type -a phantomjs > /dev/null 2>&1'
  end
end
