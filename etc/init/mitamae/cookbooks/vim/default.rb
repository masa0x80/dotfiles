case node[:platform]
when 'darwin'
  package 'vim' do
    options '--with-lua --without-python'
  end
when 'centos'
  package 'vim' do
    action :remove
  end

  %w(
    lua
    lua-devel
  ).each do |pkg|
    package pkg
  end

  execute 'install vim' do
    command <<-"EOF"
      wget ftp://ftp.vim.org/pub/vim/unix/vim-#{node[:vim][:version]}.tar.bz2
      tar jxf vim-#{node[:vim][:version]}.tar.bz2
    EOF
    cwd node[:src_dir]
    not_if "test -e #{node[:src_dir]}/vim-#{node[:vim][:version]}.tar.bz2"
  end

  execute "./configure #{node[:vim][:make_options]} && make && make install" do
    cwd File.join(node[:src_dir], "vim#{node[:vim][:version].to_s.gsub(/\./, '')}")
    not_if "type -a vim > /dev/null 2>&1 && command vim --version | grep #{node[:vim][:version]}"
  end
end
