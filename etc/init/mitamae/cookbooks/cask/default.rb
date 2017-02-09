execute 'brew tap caskroom/cask'

node[:cask_apps].each do |pkg|
  execute "brew cask install #{pkg}"
end
