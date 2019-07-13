include_cookbook 'mysql'

include_cookbook 'pyenv' do
  recipe 'python3'
end

pip3 'mycli'
