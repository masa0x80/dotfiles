include_recipe '../pyenv/install.rb'

execute 'pip install neovim' do
  command "zsh -lc 'pip install neovim'"
  not_if  "zsh -lc 'pip list | grep neovim'"
end
