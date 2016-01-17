package node[:remi_repo][:rpm_url] do
  action :install
  user   'root'
  not_if 'rpm -q %s' % node[:remi_repo][:package]
end

%w[
  epel-release
  git
  zsh
  man
  man-pages
  tree
  wget
  bind-utils
  nc
  tmpwatch
  ntp
  cronie-anacron
  libselinux-python
  fuse-libs
  lbzip2
].each do |name|
  package name do
    action :install
    user   'root'
  end
end
