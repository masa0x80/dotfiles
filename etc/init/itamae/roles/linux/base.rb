node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'linux/yum/update.rb',
      tags: %w[common yum],
    }, {
      path: 'linux/basic_tools/install.rb',
      tags: %w[common basic_tools],
    }, {
      path: 'linux/keychain/install.rb',
      tags: %w[common keychain],
    }, {
      path: 'linux/mysql/install.rb',
      tags: %w[common mysql],
    },
  ]
)
