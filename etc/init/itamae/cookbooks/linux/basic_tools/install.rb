%w[
  epel-release
  man
  man-pages
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
    user   'root'
  end
end

package node[node[:os_version]][:remi_repo][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[node[:os_version]][:remi_repo][:package]
end
