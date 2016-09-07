%w[
  kernel-headers
  kernel-devel
  dkms
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'download repo file' do
  command <<-"EOF"
    cd /etc/yum.repos.d
    curl -LO #{node[:virtualbox][:yum_repository]}
  EOF
  user   'root'
  not_if 'test -e /etc/yum.repos.d/virtualbox.repo'
end

package "#{node[:virtualbox][:package]}" do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:virtualbox][:package]
end

package node[:vagrant][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:vagrant][:package]
end

execute 'setup virtualbox' do
  command '/usr/lib/virtualbox/vboxdrv.sh setup'
  user    'root'
  not_if 'rpm -q %s' % node[:virtualbox][:package]
end
