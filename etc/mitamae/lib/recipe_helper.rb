MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end

  def include_role(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'roles', name, 'default')
  end

  def cask(pkg)
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
end
