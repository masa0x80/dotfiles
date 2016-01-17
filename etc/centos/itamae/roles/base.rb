RECIPES = [
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
    path: 'pt/install.rb',
    tags: %w[common pt],
  }, {
    path: 'jq/install.rb',
    tags: %w[common jq],
  }, {
    path: 'mysql/install.rb',
    tags: %w[common mysql],
  }, {
    path: 'imagemagick/install.rb',
    tags: %w[append imagemagick],
  }, {
    path: 'aws/install.rb',
    tags: %w[append aws],
  }, {
    path: 'redis/install.rb',
    tags: %w[append redis],
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
  },
]
TAGS = ENV.fetch('TAGS', '').split(/,/)

def build_path(path)
  '../cookbooks/%s' % path
end

RECIPES.each do |recipe|
  if TAGS.empty? || TAGS.any?{ |tag| recipe[:tags].include?(tag) }
    include_recipe build_path(recipe[:path])
  end
end
