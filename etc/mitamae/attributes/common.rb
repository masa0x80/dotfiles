node[:roles] = ENV.fetch('DOTFILE_ROLE', 'common').split(',')

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
  src_dir: '/tmp/src',
  bin_dir: '/usr/local',
  env: {}
)

node[:env][:home] = case node[:platform]
                    when 'darwin'
                      File.join('/Users', node[:user])
                    else
                      File.join('/home', node[:user])
                    end
node[:env].reverse_merge!(
  cargo_home: File.join(node[:env][:home], '.cargo'),
  gopath: File.join(node[:env][:home], '.go')
)
node[:env][:path] = %W[
  #{File.join(node[:env][:home], '.anyenv', 'bin')}
  #{File.join(node[:env][:home], '.cargo', 'bin')}
  #{File.join(node[:env][:home], '.go', 'bin')}
  /usr/local/go/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
].join(':')

node[:env][:python_configure_opts] = ENV['PYTHON_CONFIGURE_OPTS']
node[:env][:library_path] = ENV['LIBRARY_PATH']

ENV['PATH'] = node[:env][:path]

node.reverse_merge!(
  proxy_config: %w(
    HTTP_PROXY
    HTTPS_PROXY
  ).map do |key|
    "export #{key}=#{ENV['HTTP_PROXY']}" if ENV['HTTP_PROXY']
  end.compact.join(' ')
)
