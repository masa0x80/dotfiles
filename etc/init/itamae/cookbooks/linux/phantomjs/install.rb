execute 'download phantomjs' do
  command "cd #{node[:src_dir]} && curl -LO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2"
  not_if 'type -a phantomjs'
end

execute 'unarchive phantomjs' do
  command "cd #{node[:src_dir]} && tar jxf phantomjs-#{node[:phantomjs][:version]}-linux-x86_64.tar.bz2"
  not_if 'type -a phantomjs'
end

execute 'install phantomjs' do
  command "cd #{node[:src_dir]}/phantomjs-#{node[:phantomjs][:version]}-linux-x86_64/bin && sudo cp phantomjs #{node[:bin_dir]}"
  not_if 'type -a phantomjs'
end
