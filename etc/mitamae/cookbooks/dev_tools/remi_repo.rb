if node[:platform] == 'redhat'
  package node[:remi_repo][:rpm_url] do
    not_if 'rpm -q %s' % node[:remi_repo][:package]
  end
end
