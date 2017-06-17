case node[:platform]
when 'darwin'
  # Install imagemagick via brew bundle
when 'redhat'
  %w(
    ImageMagick7
    ImageMagick7-devel
    ImageMagick7-libs
  ).each do |pkg|
    package pkg do
      action  :install
      options '--enablerepo=remi'
    end
  end
end
