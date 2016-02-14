node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'zplug/install.rb',
      tags: %w[append zplug],
    }, {
      path: 'vim-plug/install.rb',
      tags: %w[append vim vim-plug-only],
    }, {
      path: 'ndenv/install.rb',
      tags: %w[append ndenv],
    }, {
      path: 'pyenv/install.rb',
      tags: %w[append pyenv],
    },
  ]
)
