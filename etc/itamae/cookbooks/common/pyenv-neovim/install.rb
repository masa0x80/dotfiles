include_recipe '../pyenv/install.rb'

execute 'install python3' do
  command "zsh -lc 'pyenv install #{node[:python][:version3]} && pyenv global #{node[:python][:version3]} #{node[:python][:version2]}'"
  not_if  "type -a pyenv && pyenv versions | grep #{node[:python][:version3]}"
end

execute 'pip install neovim' do
  command "zsh -lc 'pip3 install neovim'"
  not_if  "zsh -lc 'pip3 list | grep neovim'"
end
