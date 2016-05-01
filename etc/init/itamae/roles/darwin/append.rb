node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'common/pyenv-neovim/install.rb',
      tags: %w[append pyenv-neovim],
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
      path: 'darwin/redis/initialize.rb',
      tags: %w[append redis_init],
    },
  ]
)
