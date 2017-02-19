case node[:platform]
when 'darwin'
  package 'fish'
when 'redhat'
  execute 'download fish repo' do
    command 'curl -LO http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo'
    cwd '/etc/yum.repos.d'
    not_if 'test -e /etc/yum.repos.d/fish.repo'
  end

  package 'fish' do
    options '--enablerepo=shells_fish_release_2'
  end
end
