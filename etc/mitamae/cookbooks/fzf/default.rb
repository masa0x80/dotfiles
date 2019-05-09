case node[:platform]
when 'darwin'
  # Install fzf via brew bundle
when 'redhat'
  git_clone File.join(node[:src_dir], 'fzf') do
    repository 'https://github.com/junegunn/fzf.git'
    depth 1
  end

  execute 'Install fzf' do
    command <<-"EOF"
      sh install
    EOF
    cwd File.join(node[:src_dir], 'fzf')
    not_if "test -d #{File.join(node[:src_dir], 'fzf')}"
  end
end
