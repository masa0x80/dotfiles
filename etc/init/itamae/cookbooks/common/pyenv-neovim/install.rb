include_recipe '../pyenv/install.rb'

execute 'install python3' do
  command <<-"EOF"
    source $HOME/.sh_env
    pyenv install #{node[:python][:version3]}
    pyenv global  #{node[:python][:version2]} #{node[:python][:version3]}
  EOF
  not_if "type -a pyenv && pyenv versions | grep #{node[:python][:version3]}"
end

execute 'pip install neovim' do
  command <<-"EOF"
    source $HOME/.sh_env
    pip3 install neovim
  EOF
  not_if 'source $HOME/.sh_env && pip3 list | grep neovim'
end
