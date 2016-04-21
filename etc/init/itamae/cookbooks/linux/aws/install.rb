%w[
  s3cmd
].each do |name|
  package name do
    action :install
    user   'root'
  end
end
