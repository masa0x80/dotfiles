node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'common/pyenv-neovim/install.rb',
      tags: %w(addition pyenv-neovim),
    }, {
      path: 'common/ndenv/install.rb',
      tags: %w(addition ndenv),
    }, {
      path: 'common/plenv/install.rb',
      tags: %w(addition perl),
    }, {
      path: 'common/pyenv/install.rb',
      tags: %w(addition pyenv),
    }, {
      path: 'macos/redis/initialize.rb',
      tags: %w(addition redis_init),
    },
  ]
)
