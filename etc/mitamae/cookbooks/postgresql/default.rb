case node[:platform]
when 'darwin'
  # Install postgres via brew bundle
when 'redhat'
  %w(
    postgresql-server
    postgresql-devel
  ).each do |pkg|
    package pkg
  end

  execute 'initialize postgresql' do
    command <<-"EOF"
      postgresql-setup initdb
      sudo -u postgress createuser #{node[:user]}
    EOF
    not_if 'type -a psql > /dev/null 2>&1'
  end
end
