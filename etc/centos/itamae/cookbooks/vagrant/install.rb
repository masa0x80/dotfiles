%w[
  kernel-devel
  dkms
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

package node[:virtualbox][node[:os_version]][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:virtualbox][node[:os_version]][:package]
end

package node[:vagrant][node[:os_version]][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:vagrant][node[:os_version]][:package]
end
