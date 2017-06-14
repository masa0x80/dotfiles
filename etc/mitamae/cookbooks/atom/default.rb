# Install atom via brew bundle

%w[
  vim-mode-plus
  vim-mode-plus-ex-mode
  markdown-preview-enhanced
].each do |plugin|
  execute "apm install #{plugin}" do
    not_if "apm list | grep -q #{plugin}"
  end
end

execute 'apm disable markdown-preview'
