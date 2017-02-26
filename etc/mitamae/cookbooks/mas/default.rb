package 'mas'

node[:mas_apps].each do |app|
  mas app
end
