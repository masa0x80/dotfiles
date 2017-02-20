case node[:platform]
when 'darwin'
  package 'redis'
  execute 'brew services start redis' do
    only_if 'brew services list redis | grep redis | grep stopped'
  end
when 'redhat'
  package 'redis' do
    options '--enablerepo=remi'
  end

  service 'redis' do
    action [:enable, :restart]
  end
end
