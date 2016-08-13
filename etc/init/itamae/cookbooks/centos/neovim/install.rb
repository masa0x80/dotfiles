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
  command "cd #{node[:src_dir]} && zsh -lc 'git clone https://github.com/neovim/neovim.git'"
  not_if  "test -e #{node[:src_dir]}/neovim"
end

execute 'install neovim' do
  command "cd #{node[:src_dir]}/neovim && make && sudo make install"
  not_if  'typo -a nvim'
end

include_recipe '../../common/pyenv-neovim/install.rb'
