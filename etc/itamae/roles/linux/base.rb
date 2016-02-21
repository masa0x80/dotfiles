node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'linux/yum/update.rb',
      tags: %w[common yum],
    }, {
      path: 'linux/basic_tools/install.rb',
      tags: %w[common basic_tools],
    }, {
      path: 'common/fzf/install.rb',
      tags: %w[common fzf],
    }, {
      path: 'linux/peco/install.rb',
      tags: %w[common peco],
    }, {
      path: 'linux/direnv/install.rb',
      tags: %w[common direnv],
    }, {
      path: 'linux/pt/install.rb',
      tags: %w[common pt],
    }, {
      path: 'linux/jq/install.rb',
      tags: %w[common jq],
    }, {
      path: 'linux/mysql/install.rb',
      tags: %w[common mysql],
    },
  ]
)
