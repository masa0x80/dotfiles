execute 'fastestmirror settings' do
  command "echo 'include_only=.jp' >> /etc/yum/pluginconf.d/fastestmirror.conf"
  user    'root'
  not_if  "grep '^include_only=.jp$' /etc/yum/pluginconf.d/fastestmirror.conf"
end

execute 'proxy settings' do
  command "echo 'proxy=#{ENV['HTTP_PROXY']}' >> /etc/yum.conf"
  user    'root'
  not_if  "[ -z '#{ENV['HTTP_PROXY']}' ] || grep '^proxy=#{ENV['HTTP_PROXY']}$' /etc/yum.conf"
end

execute 'yum update' do
  command 'yum update -y'
  user    'root'
end
