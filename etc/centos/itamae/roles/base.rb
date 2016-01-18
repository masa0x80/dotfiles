node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'yum/update.rb',
      tags: %w[common yum],
    }, {
      path: 'basic_tools/install.rb',
      tags: %w[common basic_tools],
    }, {
      path: 'fzf/install.rb',
      tags: %w[common fzf],
    }, {
      path: 'peco/install.rb',
      tags: %w[common peco],
    }, {
      path: 'direnv/install.rb',
      tags: %w[common direnv],
    }, {
      path: 'pt/install.rb',
      tags: %w[common pt],
    }, {
      path: 'jq/install.rb',
      tags: %w[common jq],
    }, {
      path: 'mysql/install.rb',
      tags: %w[common mysql],
    },
  ]
)
