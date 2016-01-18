node[:recipes] = node[:recipes] || []

TAGS = ENV.fetch('TAGS', '').split(/,/)

%w[
  base
  append
].each do |role|
  include_recipe 'roles/%s.rb' % role
end

node[:recipes].each do |recipe|
  if TAGS.empty? || TAGS.any?{ |tag| recipe[:tags].include?(tag) }
    include_recipe 'cookbooks/%s' % recipe[:path]
  end
end
