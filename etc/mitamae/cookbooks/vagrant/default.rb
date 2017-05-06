no_active_vagrant = system('vagrant global-status | grep "There are no active Vagrant environments on this computer" >/dev/null')

case node[:platform]
when 'darwin'
  cask 'vagrant'

  if no_active_vagrant
    cask 'virtualbox'
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

  if no_active_vagrant
    execute 'setup virtualbox' do
      command '/usr/lib/virtualbox/vboxdrv.sh setup'
      not_if 'rpm -q %s' % node[:virtualbox][:package]
    end
  end
end
