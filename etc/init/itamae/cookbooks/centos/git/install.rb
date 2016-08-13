%w[
  gcc-c++
  curl-devel
  expat-devel
  gettext-devel
  openssl-devel
  zlib-devel
  perl-ExtUtils-MakeMaker
  xmlto
  asciidoc
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'download git' do
  command "cd #{node[:src_dir]} && curl -LO https://www.kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.gz"
  not_if  "type -a git && git version | grep #{node[:git][:version]}"
end

execute 'unarchive git' do
  command "cd #{node[:src_dir]} && tar zxf git-#{node[:git][:version]}.tar.gz"
  not_if  "type -a git && git version | grep #{node[:git][:version]}"
end

execute 'install git' do
  command "cd #{node[:src_dir]}/git-#{node[:git][:version]} && ./configure --prefix=/usr/local && make && sudo make install"
  not_if  "type -a git && git version | grep #{node[:git][:version]}"
end

execute 'install git-man' do
  command "cd #{node[:src_dir]}/git-#{node[:git][:version]} && sudo make install-man"
  not_if  "type -a git && git version | grep #{node[:git][:version]}"
end

%w[
  git
].each do |name|
  package name do
    action :remove
    user   'root'
  end
end
