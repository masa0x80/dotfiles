case node[:platform]
when 'darwin'
  # Install redis via brew bundle
when 'redhat'
  package 'redis' do
    options '--enablerepo=remi'
  end

  service 'redis' do
    action [:enable, :restart]
  end
end
