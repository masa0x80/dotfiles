execute 'xcode --install' do
  not_if 'type -a xcode-select > /dev/null 2>&1'
end

include_cookbook 'dev_tools'

node[:roles].each do |r|
  dev_tools r
  include_role r
end

include_cookbook 'cask' do
  recipe 'cleanup'
end
