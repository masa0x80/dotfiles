define :dev_tools do
  platform = node[:platform].to_sym
  role = params[:name].to_sym

  case platform
  when :darwin
    execute 'brew bundle' do
      command <<-"EOF"
        #{node[:proxy_config]}
        export PATH=#{node[:env][:path]}
        brew tap homebrew/bundle
        brew bundle --file=#{File.join(File.expand_path('../../..', __FILE__), 'attributes', "Brewfile.#{role}")}
      EOF
      cwd File.join(node[:env][:home], '.brewfile')
      user node[:user]
    end
  when :redhat
    node[:packages][platform][role].each do |pkg|
      package pkg
    end
  end
end
