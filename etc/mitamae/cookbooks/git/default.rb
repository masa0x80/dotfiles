case node[:platform]
when 'darwin'
  package 'git'
when 'redhat'
  %w(
    gcc-c++
    curl-devel
    expat-devel
    gettext-devel
    openssl-devel
    zlib-devel
    perl-ExtUtils-MakeMaker
    xmlto
    asciidoc
  ).each do |pkg|
    package pkg
  end

  execute 'download git' do
    command <<-"EOF"
      curl -LO https://www.kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.gz
      tar zxf git-#{node[:git][:version]}.tar.gz
    EOF
    cwd node[:src_dir]
    not_if "test -d #{File.join(node[:src_dir], "git-#{node[:git][:version]}")}"
  end

  execute "./configure --prefix=#{node[:bin_dir]} && make && make install && make install-man" do
    cwd File.join(node[:src_dir], "git-#{node[:git][:version]}")
    not_if "type -a git > /dev/null 2>&1 && git version | grep #{node[:git][:version]}"
  end

  package 'git' do
    action :remove
    not_if "type -a git > /dev/null 2>&1 && git version | grep #{node[:git][:version]}"
  end
end
