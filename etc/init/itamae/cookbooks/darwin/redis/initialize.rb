execute 'brew services start redis' do
  only_if 'uname | grep Darwin && brew services list redis | grep redis | grep stopped'
end
