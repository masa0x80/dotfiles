if node[:platform] == 'darwin'
  node.reverse_merge!(
    cask_apps: %w(
      alfred
      appcleaner
      bettertouchtool
      firefox
      google-chrome
      iterm2
      itsycal
    )
  )
end

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],

  src_dir: '/tmp/src',
  bin_dir: '/usr/local',

  git: {
    version: '2.11.0'
  },
  global: {
    version: '6.5.6'
  },
  golang: {
    version: '1.7'
  },
  jo: {
    version: '1.0'
  },
  mysql: {
    rpm_url: 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm',
    package: 'mysql57-community-release'
  },
  nodejs: {
    version: 'v6.5.0'
  },
  phantomjs: {
    version: '2.1.1'
  },
  perl: {
    version: '5.22.1'
  },
  python: {
    version2: '2.7.12',
    version3: '3.5.2'
  },
  ruby: {
    version: '2.4.0'
  },
  remi_repo: {
    rpm_url: 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
    package: 'remi-release'
  },
  tmux: {
    version: '2.3'
  },
  vagrant: {
    rpm_url: 'https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm',
    package: 'vagrant-1.9.1-1.x86_64'
  },
  vim: {
    version: '8.0',
    make_options: '--enable-fail-if-missing --enable-fontset --enable-cscope --enable-multibyte --enable-rubyinterp --enable-luainterp --with-x=no --disable-gui --disable-xim --with-features=huge --disable-selinux --disable-gpm --disable-darwin'
  },
  virtualbox: {
    yum_repository: 'http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo',
    package: 'VirtualBox-5.1'
  }
)

def home_dir
  node[:home] = case node[:platform]
  when 'darwin'
    File.join('/Users', node[:user])
  else
    File.join('/home', node[:user])
  end
end

def build_paths
  paths = []
  paths << File.join(home_dir, '.go', 'bin')
  paths << '/usr/local/go/bin'
  paths << '/usr/local/bin'
  paths << '/usr/bin'
  paths << '/bin'
  paths << '/usr/local/sbin'
  paths << '/usr/sbin'
  paths.join(':')
end
ENV['PATH'] = build_paths
ENV['GOPATH'] = File.join(home_dir, '.go')

node[:proxy_config] = %w(
  HTTP_PROXY
  HTTPS_PROXY
).map do |key|
  "export #{key}=#{ENV['HTTP_PROXY']}" if ENV['HTTP_PROXY']
end.compact.join(' ')
