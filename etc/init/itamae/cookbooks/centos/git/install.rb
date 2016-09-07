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

execute 'install git' do
  command <<-"EOF"
    cd #{node[:src_dir]}
    curl -LO https://www.kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.gz
    tar zxf git-#{node[:git][:version]}.tar.gz
    cd #{node[:src_dir]}/git-#{node[:git][:version]}
    ./configure --prefix=/usr/local
    make
    sudo make install
    sudo make install-man
  EOF
  not_if "type -a git && git version | grep #{node[:git][:version]}"
end

%w[
  git
].each do |name|
  package name do
    action :remove
    user   'root'
  end
end
