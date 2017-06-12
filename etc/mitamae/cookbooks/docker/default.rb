case node[:platform]
when 'darwin'
  # Install docker via brew bundle
when 'redhat'
  package 'docker'
end
