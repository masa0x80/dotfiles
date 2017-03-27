include_attribute 'common'
include_attribute 'packages'
include_attribute 'versions'
include_attribute 'golang_repos'

if node[:platform] == 'darwin'
  include_attribute 'mas'
  include_attribute 'cask'
end
