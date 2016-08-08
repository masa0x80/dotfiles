node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'linux/imagemagick/install.rb',
      tags: %w[append imagemagick],
    }, {
      path: 'linux/golang/install.rb',
      tags: %w[append golang],
    }, {
      path: 'linux/aws/install.rb',
      tags: %w[append aws],
    }, {
      path: 'linux/redis/install.rb',
      tags: %w[append redis],
    }, {
      path: 'linux/postgresql/install.rb',
      tags: %w[append postgresql],
    }, {
      path: 'linux/neovim/install.rb',
      tags: %w[append neovim],
    }, {
      path: 'linux/global/install.rb',
      tags: %w[append global],
    }, {
      path: 'linux/tmux/install.rb',
      tags: %w[append tmux],
    }, {
      path: 'linux/git/install.rb',
      tags: %w[append git],
    }, {
      path: 'common/ndenv/install.rb',
      tags: %w[append ndenv],
    }, {
      path: 'common/plenv/install.rb',
      tags: %w[append perl],
    }, {
      path: 'common/pyenv/install.rb',
      tags: %w[append pyenv],
    }, {
      path: 'linux/gibo/install.rb',
      tags: %w[append gibo],
    }, {
      path: 'linux/phantomjs/install.rb',
      tags: %w[append phantomjs],
    }, {
      path: 'linux/docker/install.rb',
      tags: %w[append docker],
    }, {
      path: 'linux/vagrant/install.rb',
      tags: %w[append vagrant],
    },
  ]
)
