%i[remove install].each do |type|
  %w[
    ImageMagick-last
    ImageMagick-last-devel
    ImageMagick-last-libs
  ].each do |name|
    package name do
      action  type
      options '--enablerepo=remi'
      user   'root'
    end
  end
end
