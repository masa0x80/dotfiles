execute 'brew bundle' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:env][:path]}
    brew tap homebrew/bundle
    brew bundle --file=#{File.join(File.expand_path('..', __FILE__), 'files', 'default', 'Brewfile')}
  EOF
  cwd File.join(node[:env][:home], '.brewfile')
  user node[:user]
end
