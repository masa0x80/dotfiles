%w[
  postgresql-server
  postgresql-devel
].each do |name|
  package name do
    action :install
    user   'root'
  end
end

execute 'initialize postgresql' do
  command <<-"EOF"
    sudo postgresql-setup initdb
    sudo -u posgress createuser #{ENV['USER']}
  EOF
  not_if 'type -a psql'
end
