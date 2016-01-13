def build_path(path)
  '../cookbooks/%s' % path
end

%w[
  basic_tools/install.rb
  mysql/install.rb
].each do |path|
  include_recipe build_path(path)
end
