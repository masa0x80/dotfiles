packages = node[:packages]
platform = node[:platform].to_sym

case platform
when :darwin
  execute 'brew bundle' do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:env][:path]}
      brew tap homebrew/bundle
      brew bundle
    EOF
    cwd File.join(node[:env][:home], '.brewfile')
    user node[:user]
  end
when :redhat
  packages[platform][:yum_list].each do |pkg|
    pkg pkg
  end

  package node[:remi_repo][:rpm_url] do
    not_if 'rpm -q %s' % node[:remi_repo][:package]
  end
end
