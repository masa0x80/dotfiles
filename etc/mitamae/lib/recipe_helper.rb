define :include_cookbook do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'cookbooks', params[:name], 'default')
end

define :include_role do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'roles', params[:name], 'default')
end

define :include_attribute do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'attributes', params[:name])
end

define :brew_tap do
  pkg = params[:name]
  execute "brew tap #{pkg}" do
    not_if "brew tap | grep -q #{pkg}"
  end
end

define :pkg do
  pkg, *options = params[:name].split(' ')
  if options.empty?
    package pkg
  else
    package pkg do
      options options.join(' ')
    end
  end
end

define :mas do
  id, pkg = params[:name].split(' ')
  execute "mas[install #{pkg}]" do
    command "mas install #{id}"
    only_if 'mas account'
  end
end

define :cask do
  pkg = params[:name]

  # install app
  execute "brew cask install #{pkg}" do
    only_if "brew cask info #{pkg} | grep -q 'Not installed'"
  end

  # reinstall app
  caskroom_dir = '/usr/local/Caskroom'
  app_dir = File.join(caskroom_dir, pkg)
  latest_version = `brew cask info #{pkg} | grep '#{pkg}:' | cut -d ' ' -f 2`.chomp
  execute "brew cask reinstall #{pkg}" do
    not_if "test -d #{app_dir}/#{latest_version}"
  end
end

define :pip3 do
  pkg = params[:name]
  execute "pip[install #{pkg}]" do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:home]}/.anyenv/bin:$PATH
      eval "$(anyenv init -)"
      pip3 list | grep -i #{pkg} || pip3 install #{pkg}
    EOF
    user node[:user]
  end
end

define :git_clone, repository: nil, user: nil do
  dest_path = params[:name]
  execute "git_clone[#{dest_path}]" do
    command <<-"EOF"
      #{node[:proxy_config]}
      git clone #{params[:repository]} #{dest_path}
    EOF
    user user || node[:user]
    not_if "test -d #{dest_path}"
  end
end
