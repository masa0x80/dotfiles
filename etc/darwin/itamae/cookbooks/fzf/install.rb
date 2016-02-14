execute 'git clone fzf' do
  command 'zsh -lc "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"'
  not_if  'test -e ~/.fzf'
end

execute 'install fzf' do
  command 'zsh -lc "~/.fzf/install --no-update-rc --completion --key-bindings"'
  not_if  'type -a fzf'
end
