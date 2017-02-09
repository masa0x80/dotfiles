case node[:platform]
when 'darwin'
  package 'imagemagick'
when 'redhat'
  %i(remove install).each do |type|
    %w(
      ImageMagick7
      ImageMagick7-devel
      ImageMagick7-libs
    ).each do |pkg|
      package pkg do
        action  type
        options '--enablerepo=remi'
      end
    end
  end
end
