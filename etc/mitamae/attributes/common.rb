node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
  src_dir: '/tmp/src',
  bin_dir: '/usr/local'
)

node.reverse_merge!(
  home: case node[:platform]
        when 'darwin'
          File.join('/Users', node[:user])
        else
          File.join('/home', node[:user])
        end
)

paths = []
paths << File.join(node[:home], '.go', 'bin')
paths << '/usr/local/go/bin'
paths << '/usr/local/bin'
paths << '/usr/bin'
paths << '/bin'
paths << '/usr/local/sbin'
paths << '/usr/sbin'
ENV['PATH'] = paths.join(':')
ENV['GOPATH'] = File.join(node[:home], '.go')

node.reverse_merge!(
  proxy_config: %w(
    HTTP_PROXY
    HTTPS_PROXY
  ).map do |key|
    "export #{key}=#{ENV['HTTP_PROXY']}" if ENV['HTTP_PROXY']
  end.compact.join(' ')
)
