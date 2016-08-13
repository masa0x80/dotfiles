node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'centos/imagemagick/install.rb',
      tags: %w[addition imagemagick],
    }, {
      path: 'centos/aws/install.rb',
      tags: %w[addition aws],
    }, {
      path: 'centos/redis/install.rb',
      tags: %w[addition redis],
    }, {
      path: 'centos/postgresql/install.rb',
      tags: %w[addition postgresql],
    }, {
      path: 'centos/neovim/install.rb',
      tags: %w[addition neovim],
    }, {
      path: 'centos/vim/install.rb',
      tags: %w[addition vim],
    }, {
      path: 'centos/global/install.rb',
      tags: %w[addition global],
    }, {
      path: 'centos/tmux/install.rb',
      tags: %w[addition tmux],
    }, {
      path: 'centos/git/install.rb',
      tags: %w[addition git],
    }, {
      path: 'common/ndenv/install.rb',
      tags: %w[addition ndenv],
    }, {
      path: 'common/plenv/install.rb',
      tags: %w[addition perl],
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
