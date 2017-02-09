package 'mas'

execute 'install mas apps' do
  command <<-"EOF"
    mas install 803453959 # Slack
    mas install 497799835 # Xcode
  EOF
  only_if 'mas account'
end
