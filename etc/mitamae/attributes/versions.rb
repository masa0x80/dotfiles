node.reverse_merge!(
  git: {
    version: '2.20.1'
  },
  global: {
    version: '6.6.3'
  },
  golang: {
    version: '1.11.4'
  },
  jo: {
    version: '1.1'
  },
  mysql: {
    rpm_url: 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm',
    package: 'mysql57-community-release'
  },
  nodejs: {
    version: '11.6.0'
  },
  perl: {
    version: '5.22.1'
  },
  phantomjs: {
    version: '2.1.1'
  },
  python: {
    version2: '2.7.15',
    version3: '3.7.2'
  },
  ruby: {
    version: '2.6.0'
  },
  remi_repo: {
    rpm_url: 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
    package: 'remi-release'
  },
  tmux: {
    version: '2.8'
  },
  vagrant: {
    rpm_url: 'https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm',
    package: 'vagrant-1.9.1-1.x86_64'
  },
  virtualbox: {
    yum_repository: 'http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo',
    package: 'VirtualBox-5.1'
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
