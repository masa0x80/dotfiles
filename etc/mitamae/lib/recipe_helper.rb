define :include_cookbook do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'cookbooks', params[:name], 'default')
end

define :include_role do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'roles', params[:name], 'default')
end

define :cask do
  pkg = params[:name]

  # install app
  execute "brew cask install #{pkg}" do
    only_if "brew cask info #{pkg} | grep -q 'Not installed'"
  end

  # remove old dir
  caskroom_dir = '/usr/local/Caskroom'
  app_dir = File.join(caskroom_dir, pkg)
  current = `brew cask info #{pkg} | grep '#{app_dir}' | cut -d ' ' -f 1`.chomp
  Dir.glob(File.join(app_dir, '*')).each do |dir|
    version = File.basename(dir)
    execute "rm -rf #{File.join(app_dir, version)}" do
      only_if "test '#{current} != '#{dir}'"
    end
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
