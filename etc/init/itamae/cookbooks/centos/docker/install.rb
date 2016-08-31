%w(
  docker
).each do |name|
  package name do
    action :install
    user   'root'
  end
end
