case node[:platform]
when 'darwin'
  package 'neovim/neovim/neovim' do
    options '--HEAD'
  end
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

include_cookbook 'pyenv'

execute 'install python3' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    type -a pyenv > /dev/null 2>&1 && pyenv versions | grep #{node[:python][:version3]} || pyenv install #{node[:python][:version3]}
    pyenv global #{node[:python][:version2]} #{node[:python][:version3]}
  EOF
  user node[:user]
end

pip3 'neovim'
