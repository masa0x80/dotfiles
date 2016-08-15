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
      path: 'centos/keychain/install.rb',
      tags: %w[basic keychain],
    }, {
      path: 'centos/golang/install.rb',
      tags: %w[basic golang],
    }, {
      path: 'centos/mysql/install.rb',
      tags: %w[basic mysql],
    },
  ]
)
