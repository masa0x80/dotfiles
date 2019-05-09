include_recipe 'lib/recipe_helper'
include_recipe 'attributes/default'

directory node[:src_dir] do
  owner node[:user]
end

if node[:platform] == 'darwin'
  execute 'xcode-select --install' do
    not_if 'type -a xcode-select > /dev/null 2>&1'
  end
end

include_cookbook 'dev_tools'

node[:roles].each do |r|
  if node[:platform] == 'redhat' && r == 'common'
    include_cookbook 'dev_tools' do
      recipe 'remi_repo'
    end
  end
  dev_tools r
  include_role r
end
