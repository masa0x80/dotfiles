case node[:platform]
when 'darwin'
    execute 'brew bundle' do
      command <<-"EOF"
        brew tap homebrew/bundle
        brew bundle --file=#{File.join(File.expand_path('../../..', __FILE__), 'attributes', "Brewfile.nvim")}
        brew cleanup
      EOF
      user node[:user]
    end
end
include_cookbook 'neovim'
