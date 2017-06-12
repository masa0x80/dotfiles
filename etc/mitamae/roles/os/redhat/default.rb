directory node[:src_dir] do
  owner node[:user]
end

include_cookbook 'yum'

include_role 'common'
