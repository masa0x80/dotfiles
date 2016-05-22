node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'linux/aws/install.rb',
      tags: %w[append aws],
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
      path: 'linux/docker/install.rb',
      tags: %w[append docker],
    }, {
      path: 'linux/vagrant/install.rb',
      tags: %w[append vagrant],
    },
  ]
)
