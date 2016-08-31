package 'redis' do
  action  :install
  options '--enablerepo=remi'
  user    'root'
end

service 'redis' do
  user   'root'
  action [:enable, :restart]
end
