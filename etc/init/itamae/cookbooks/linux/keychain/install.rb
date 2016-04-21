execute 'git clone keychain' do
  command "cd #{node[:src_dir]} && zsh -lc 'git clone https://github.com/funtoo/keychain.git'"
  not_if "test -e #{node[:src_dir]}/keychain"
end

execute 'install keychain' do
  command "cd #{node[:src_dir]}/keychain && make && sudo cp keychain /usr/local/bin"
  not_if  'typo -a keychain'
end
