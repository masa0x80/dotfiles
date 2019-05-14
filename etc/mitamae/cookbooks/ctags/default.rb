case node[:platform]
when 'darwin'
  # Install docker via brew bundle
when 'redhat'
  git File.join(node[:src_dir], 'ctags') do
    repository 'https://github.com/universal-ctags/ctags.git'
  end

  execute './autogen.sh && ./configure --prefix=/usr/local && make && make install' do
    cwd File.join(node[:src_dir], 'ctags')
    not_if "type -a ctags > /dev/null 2>&1"
  end
end
