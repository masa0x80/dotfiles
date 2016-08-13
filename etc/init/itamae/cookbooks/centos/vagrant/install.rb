%w[
  kernel-devel
  dkms
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

package node[node[:os_version]][:virtualbox][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[node[:os_version]][:virtualbox][:package]
end

package node[:vagrant][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:vagrant][:package]
end

execute 'setup virtualbox' do
  command '/sbin/rcvboxdrv setup'
  user    'root'
end
