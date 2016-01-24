node[:recipes] = node[:recipes].concat(
  [
    {
      path: 'imagemagick/install.rb',
      tags: %w[append imagemagick],
    }, {
      path: 'aws/install.rb',
      tags: %w[append aws],
    }, {
      path: 'redis/install.rb',
      tags: %w[append redis],
    }, {
      path: 'postgresql/install.rb',
      tags: %w[append postgresql],
    }, {
      path: 'zplug/install.rb',
      tags: %w[append zplug],
    }, {
      path: 'vim/install.rb',
      tags: %w[append vim vim-only],
    }, {
      path: 'vim-plug/install.rb',
      tags: %w[append vim vim-plug-only],
    }, {
      path: 'tmux/install.rb',
      tags: %w[append tmux],
    }, {
      path: 'git/install.rb',
      tags: %w[append git],
    }, {
      path: 'ndenv/install.rb',
      tags: %w[append ndenv],
    }, {
      path: 'pyenv/install.rb',
      tags: %w[append pyenv],
    }, {
      path: 'docker/install.rb',
      tags: %w[append docker],
    }, {
      path: 'vagrant/install.rb',
      tags: %w[append vagrant],
    },
  ]
)
