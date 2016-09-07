execute 'install phantomjs' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2
    tar jxf phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2
    cd #{node[:src_dir]}/phantomjs-#{node[:phantomjs][:version]}-linux-x86_64/bin
    sudo cp phantomjs #{node[:bin_dir]}
  EOF
  not_if 'type -a phantomjs'
end
