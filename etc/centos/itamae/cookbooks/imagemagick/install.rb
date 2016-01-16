%w[
  ImageMagick-last
  ImageMagick-last-devel
  ImageMagick-last-libs
].each do |name|
  package name do
    action :install
    options '--enablerepo=remi'
    user   'root'
  end
end
