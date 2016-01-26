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
  not_if "test -e #{node[:src_dir]}/neovim"
end

execute 'install neovim' do
  command "cd #{node[:src_dir]}/neovim && make && sudo make install"
  not_if  'typo -a nvim'
end

include_recipe '../pyenv/install.rb'

execute 'install python3' do
  command "zsh -lc 'pyenv install #{node[:python][:version3]} && pyenv global #{node[:python][:version3]} #{node[:python][:version2]}'"
  not_if  "type -a pyenv && pyenv versions | grep #{node[:python][:version3]}"
end

execute 'pip install neovim' do
  command "zsh -lc 'pip install neovim'"
  not_if  "zsh -lc 'pip list | grep neovim'"
end
