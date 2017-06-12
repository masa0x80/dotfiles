execute 'xcode --install' do
  not_if 'type -a xcode-select > /dev/null 2>&1'
end

include_role 'common'

include_cookbook 'cask' do
  recipe 'cleanup'
end
