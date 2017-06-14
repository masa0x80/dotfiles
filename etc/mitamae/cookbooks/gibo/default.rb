case node[:platform]
when 'darwin'
  # Install gibo via brew bundle
when 'redhat'
  include_cookbook 'git'

  execute 'install gibo' do
    command <<-"EOF"
      curl -LO https://raw.github.com/simonwhitaker/gibo/master/gibo
      chmod +x gibo
      mv gibo #{node[:bin_dir]}/bin
      #{node[:bin_dir]}/bin/gibo -u
    EOF
    cwd node[:src_dir]
    not_if 'type -a gibo > /dev/null 2>&1'
  end
end
