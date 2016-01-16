def build_path(path)
  '../cookbooks/%s' % path
end

%w[
  yum/update.rb
  basic_tools/install.rb
  mysql/install.rb
  fzf/install.rb
].each do |path|
  include_recipe build_path(path)
end
