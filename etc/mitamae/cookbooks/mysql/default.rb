case node[:platform]
when 'darwin'
  # Install mysql via brew bundle
when 'redhat'
  package node[:mysql][:rpm_url] do
    not_if 'rpm -q %s' % node[:mysql][:package]
  end

  %w(
    mysql-community-devel
    mysql-community-server
    mysql-community-libs
  ).each do |pkg|
    package pkg
  end

  service 'mysqld' do
    action [:enable, :restart]
  end
end
