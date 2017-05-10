execute 'xcode --install' do
  not_if 'type -a xcode-select > /dev/null 2>&1'
end

include_role 'common'
include_role 'append'

include_cookbook 'cask'
include_cookbook 'atom'
include_cookbook 'mas'
