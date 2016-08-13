node[:recipes] = node[:recipes] || []

TAGS = ENV.fetch('TAGS', '').split(/,/)

uname = `uname`.downcase.chomp

%w[
  basic
  addition
].each do |role|
  include_recipe 'roles/%s/%s.rb' % [uname, role]
end

node[:recipes].each do |recipe|
  if TAGS.empty? || TAGS.any?{ |tag| recipe[:tags].include?(tag) }
    include_recipe 'cookbooks/%s' % recipe[:path]
  end
end
