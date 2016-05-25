execute 'install gibo' do
  command "cd #{node[:src_dir]} && curl -LO https://raw.github.com/simonwhitaker/gibo/master/gibo && chmod +x gibo && sudo mv gibo /usr/local/bin/ && gibo -u"
  not_if 'type -a gibo'
end
