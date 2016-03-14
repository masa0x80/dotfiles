node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'common/mysql/initialize.rb',
      tags: %w[append mysql_init],
    },
  ]
)
