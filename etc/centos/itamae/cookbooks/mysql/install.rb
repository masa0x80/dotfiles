package node[:mysql][node[:os_version]][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:mysql][node[:os_version]][:package]
end

%w[
  mysql-community-devel
  mysql-community-server
  mysql-community-libs
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

service 'mysqld' do
  user   'root'
  action [:enable, :restart]
end
