%w[
  libtool
  autoconf
  automake
  cmake
  gcc
  gcc-c++
  make
  pkgconfig
  unzip
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'git clone neovim' do
  command "zsh -lc 'git clone https://github.com/neovim/neovim.git'"
  cwd     node[:src_dir]
  not_if  "test -e #{node[:src_dir]}/neovim"
end

execute 'install neovim' do
  command "make && sudo make install"
  cwd     "#{node[:src_dir]}/neovim"
  not_if  'typo -a nvim'
end

include_recipe '../../common/pyenv-neovim/install.rb'
