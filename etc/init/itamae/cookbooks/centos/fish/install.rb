execute 'download fish repo' do
  command "cd /etc/yum.repos.d && curl -LO http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo"
  user    'root'
  not_if  'test -e /etc/yum.repos.d/fish.repo'
end

package 'fish' do
  action :install
  user   'root'
end
