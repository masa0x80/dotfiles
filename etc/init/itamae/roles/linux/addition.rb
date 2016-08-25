node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'centos/imagemagick/install.rb',
      tags: %w[addition imagemagick],
    }, {
      path: 'centos/aws/install.rb',
      tags: %w[addition aws],
    }, {
      path: 'centos/jo/install.rb',
      tags: %w[addition jo],
    }, {
      path: 'centos/postgresql/install.rb',
      tags: %w[addition postgresql],
    }, {
      path: 'centos/vim/install.rb',
      tags: %w[addition vim],
    }, {
      path: 'centos/global/install.rb',
      tags: %w[addition global],
    }, {
      path: 'centos/git/install.rb',
      tags: %w[addition git],
    }, {
      path: 'common/ndenv/install.rb',
      tags: %w[addition ndenv],
    }, {
      path: 'common/plenv/install.rb',
      tags: %w[addition plenv],
    }, {
      path: 'common/pyenv/install.rb',
      tags: %w[addition pyenv],
    }, {
      path: 'centos/gibo/install.rb',
      tags: %w[addition gibo],
    }, {
      path: 'centos/phantomjs/install.rb',
      tags: %w[addition phantomjs],
    }, {
      path: 'centos/docker/install.rb',
      tags: %w[addition docker],
    }, {
      path: 'centos/vagrant/install.rb',
      tags: %w[addition vagrant],
    },
  ]
)
