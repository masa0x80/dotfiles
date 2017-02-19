execute 'fastestmirror settings' do
  command "echo 'include_only=.jp' >> /etc/yum/pluginconf.d/fastestmirror.conf"
  not_if  "grep '^include_only=.jp$' /etc/yum/pluginconf.d/fastestmirror.conf"
end

execute 'proxy settings' do
  command "echo 'proxy=#{ENV['HTTP_PROXY']}' >> /etc/yum.conf"
  not_if  "[ -z '#{ENV['HTTP_PROXY']}' ] || grep '^proxy=#{ENV['HTTP_PROXY']}$' /etc/yum.conf"
end

execute 'yum update -y'
