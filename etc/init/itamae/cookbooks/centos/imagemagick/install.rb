%i(remove install).each do |type|
  %w(
    ImageMagick7
    ImageMagick7-devel
    ImageMagick7-libs
  ).each do |name|
    package name do
      action  type
      options '--enablerepo=remi'
      user    'root'
    end
  end
end
