case node[:platform]
when 'darwin'
  # Install redis via brew bundle
when 'redhat'
  package 'redis' do
    options '--enablerepo=remi'
  end
end
