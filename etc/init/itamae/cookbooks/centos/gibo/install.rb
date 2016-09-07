execute 'install gibo' do
  command <<-"EOF"
    curl -LO https://raw.github.com/simonwhitaker/gibo/master/gibo
    chmod +x gibo
    sudo mv gibo /usr/local/bin/
    gibo -u
  EOF
  cwd    node[:src_dir]
  not_if 'type -a gibo'
end
