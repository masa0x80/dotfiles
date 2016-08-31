execute 'git clone keychain' do
  command 'git clone https://github.com/funtoo/keychain.git'
  cwd     node[:src_dir]
  not_if  "test -e #{node[:src_dir]}/keychain"
end

execute 'install keychain' do
  command 'make && sudo cp keychain /usr/local/bin'
  cwd     "#{node[:src_dir]}/keychain"
  not_if  'typo -a keychain'
end
