node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'common/zplug/install.rb',
      tags: %w[append zplug],
    }, {
      path: 'common/pyenv-neovim/install.rb',
      tags: %w[append pyenv-neovim],
    }, {
      path: 'common/ndenv/install.rb',
      tags: %w[append ndenv],
    }, {
      path: 'common/pyenv/install.rb',
      tags: %w[append pyenv],
    },
  ]
)
