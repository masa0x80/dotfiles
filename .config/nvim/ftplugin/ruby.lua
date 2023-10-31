vim.cmd([[
  iabbrev bb binding.pry<Esc>
  iabbrev bB require 'pry'; binding.pry<Esc>
  iabbrev BB require 'byebug'; byebug<Esc>
  iabbrev Bb binding.irb<Esc>
  iabbrev reqb require 'bundler'<CR>Bundler.require<CR><Esc>
]])
