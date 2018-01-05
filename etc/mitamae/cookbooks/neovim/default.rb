case node[:platform]
when 'darwin'
  # Install neovim via brew bundle
when 'redhat'
  %w(
    libtool
    autoconf
    automake
    cmake
    gcc
    gcc-c++
    make
    pkgconfig
    unzip
  ).each do |pkg|
    package pkg
  end

  git_clone "#{node[:src_dir]}/neovim" do
    repository 'https://github.com/neovim/neovim.git'
  end

  execute 'make && make install' do
    cwd "#{node[:src_dir]}/neovim"
    not_if 'typo -a nvim > /dev/null 2>&1'
  end
end
