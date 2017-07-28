define :dev_tools do
  role = params[:name].to_sym

  case node[:platform]
  when 'darwin'
    execute 'brew bundle' do
      command <<-"EOF"
        #{node[:proxy_config]}
        export PATH=#{node[:env][:path]}
        brew tap homebrew/bundle
        brew bundle --file=#{File.join(File.expand_path('../../..', __FILE__), 'attributes', "Brewfile.#{role}")}
        brew cleanup
      EOF
      user node[:user]
    end
  when 'redhat'
    node[:yum_packages][role].each do |pkg|
      package pkg
    end
  end
end
