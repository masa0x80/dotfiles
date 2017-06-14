directory node[:src_dir] do
  owner node[:user]
end

include_cookbook 'yum'
include_cookbook 'dev_tools'

node[:roles].each do |r|
  if r == 'common'
    include_cookbook 'dev_tools' do
      recipe 'remi_repo'
    end
  end
  dev_tools r
  include_role r
end
