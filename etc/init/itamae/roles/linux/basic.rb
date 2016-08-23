node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'centos/yum/update.rb',
      tags: %w[basic yum],
    }, {
      path: 'centos/basic_tools/install.rb',
      tags: %w[basic basic_tools],
    }, {
      path: 'centos/fish/install.rb',
      tags: %w[basic fish],
    }, {
      path: 'centos/neovim/install.rb',
      tags: %w[basic neovim],
    }, {
      path: 'centos/tmux/install.rb',
      tags: %w[basic tmux],
    }, {
      path: 'centos/keychain/install.rb',
      tags: %w[basic keychain],
    }, {
      path: 'centos/golang/install.rb',
      tags: %w[basic golang],
    }, {
      path: 'centos/mysql/install.rb',
      tags: %w[basic mysql],
    }, {
      path: 'centos/redis/install.rb',
      tags: %w[basic redis],
    },
  ]
)
