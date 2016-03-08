execute 'install zplug' do
  command 'git clone https://github.com/b4b4r07/zplug ~/.zplug'
  not_if  'test -e ~/.zplug'
end
