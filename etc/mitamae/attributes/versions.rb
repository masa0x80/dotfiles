node.reverse_merge!(
  git: {
    version: '2.21.0'
  },
  golang: {
    version: '1.12.5'
  },
  jo: {
    version: '1.2'
  },
  mysql: {
    rpm_url: 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm',
    package: 'mysql57-community-release'
  },
  nodejs: {
    version: '12.4.0'
  },
  perl: {
    version: '5.22.1'
  },
  python: {
    version2: '2.7.16',
    version3: '3.7.2'
  },
  ruby: {
    version: '2.6.3'
  },
  remi_repo: {
    rpm_url: 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
    package: 'remi-release'
  },
  tmux: {
    version: '2.9'
  },
  vagrant: {
    rpm_url: 'https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm',
    package: 'vagrant-2.2.4-1.x86_64'
  },
  virtualbox: {
    yum_repository: 'http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo',
    package: 'VirtualBox-6.0'
  },
  vim: {
    version: '8.1',
    make_options: %w[
      --enable-fail-if-missing
      --enable-fontset
      --enable-cscope
      --enable-multibyte
      --enable-rubyinterp
      --enable-luainterp
      --with-x=no
      --disable-gui
      --disable-xim
      --with-features=huge
      --disable-selinux
      --disable-gpm
      --disable-darwin
    ].join(' ')
  }
)
