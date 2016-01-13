include_recipe './attributes.rb'

package node[:remi][:rpm_url] do
  action :install
  not_if 'rpm -q %s' % node[:remi][:package]
end

%w[
  epel-release
  git
  zsh
  man
  man-pages
  tree
  wget
  bind-utils
  nc
  tmpwatch
  ntp
  cronie-anacron
  libselinux-python
  fuse-libs
  lbzip2
].each do |name|
  package name do
    action :install
  end
end
