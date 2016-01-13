include_recipe './attributes.rb'

package node[:mysql][:rpm_url] do
  action :install
  not_if 'rpm -q %s' % node[:mysql][:package]
end

%w[
  mysql-community-devel
  mysql-community-server
  mysql-community-libs
].each do |name|
  package name do
    action :install
  end
end

service 'mysqld' do
  action [:enable, :restart]
end
