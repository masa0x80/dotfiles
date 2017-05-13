node[:cask_apps].each do |pkg|
  cask pkg
end

execute 'brew cask cleanup'
