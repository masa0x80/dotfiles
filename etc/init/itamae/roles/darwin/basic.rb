node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'macos/basic/initialize.rb',
      tags: %w(basic basic_init),
    }, {
      path: 'common/golang_tools/install.rb',
      tags: %w(basic golang_tools),
    },
  ]
)
