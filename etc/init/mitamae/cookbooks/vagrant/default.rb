case node[:platform]
when 'darwin'
  %w(
    vagrant
    virtualbox
  ).each do |pkg|
    execute "brew cask install #{pkg}"
  end
when 'redhat'
  %w(
    kernel-headers
    kernel-devel
    dkms
  ).each do |pkg|
    package pkg
  end

  execute 'download repo file' do
    command <<-"EOF"
      cd /etc/yum.repos.d
      curl -LO #{node[:virtualbox][:yum_repository]}
    EOF
    not_if 'test -e /etc/yum.repos.d/virtualbox.repo'
  end

  package node[:virtualbox][:package]

  package node[:vagrant][:rpm_url] do
    not_if 'rpm -q %s' % node[:vagrant][:package]
  end

  execute 'setup virtualbox' do
    command '/usr/lib/virtualbox/vboxdrv.sh setup'
    not_if 'rpm -q %s' % node[:virtualbox][:package]
  end
end
