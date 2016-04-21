%w[
  redis
].each do |name|
  package name do
    action  :install
    options '--enablerepo=remi'
    user    'root'
  end
end

service 'redis' do
  user   'root'
  action [:enable, :restart]
end
