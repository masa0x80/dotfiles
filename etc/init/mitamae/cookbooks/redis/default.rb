case node[:platform]
when 'darwin'
  package 'redis'
  execute 'brew services start redis'
when 'redhat'
  package 'redis' do
    options '--enablerepo=remi'
  end

  service 'redis' do
    action [:enable, :restart]
  end
end
