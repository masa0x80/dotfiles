case node[:platform]
when 'darwin'
  execute 'brew tap homebrew/services'

  package 'homebrew/dupes/less'
  package 'homebrew/dupes/lsof'
  package 'homebrew/dupes/rsync'

  package 'autoconf'
  package 'automake'
  package 'boost'
  package 'cmake'
  package 'coreutils'
  package 'cpulimit'
  package 'curl'
  package 'emojify'
  package 'gdbm'
  package 'gettext'
  package 'zsh' do
    options '--without-etcdir'
  end
when 'redhat'
  package 'epel-release'

  %w(
    automake
    autoconf
    bind-utils
    bzip2-devel
    cronie-anacron
    fuse-libs
    gcc-c++
    libffi-devel
    libselinux-python
    libxslt-devel
    nc
    ntp
    man
    man-pages
    openssl-devel
    patch
    readline-devel
    sqlite-devel
    tmpwatch
    tree
    wget
    xsel
    zlib-devel
    zsh
  ).each do |pkg|
    package pkg
  end

  package node[:remi_repo][:rpm_url] do
    not_if 'rpm -q %s' % node[:remi_repo][:package]
  end
end

include_cookbook 'git'
