require("config._")

require("config.options")
require("config.keymaps")
require("config.colorscheme")

-- Plugins
require("config.plugins")

require("config.comment")
require("config.which-key")
require("config.impatient")

-- Cmp plugins
require("config.cmp")
require("config.lsp")

-- LSP
require("config.lsp.lspsaga")
require("config.lsp.fidget")
require("config.lsp.ale")

-- Debug
require("config.vimspector")

-- Test
require("config.vim-test")
require("config.jaq")

-- Telescope
require("config.telescope")

-- Treesitter
require("config.treesitter")
require("config.treesitter-unit")

-- UI
require("config.illuminate")
require("config.scrollbar")
require("config.hlslens")
require("config.colorizer")
require("config.modes")
require("config.lualine")

-- Ops
require("config.lightspeed")
require("config.BackAndForward")

-- Git
require("config.gitsigns")
require("config.git-conflict")
require("config.vgit")

-- Filer
require("config.neo-tree")

-- Markdown
require("config.markdown-preview")

require("config.easy-align")
require("config.todo-comments")
require("config.dial")
require("config.spectre")
require("config.trouble")
require("config.neogen")

require("config.toggleterm")

-- Misc
require("misc.markdown")
require("misc.todo")
require("misc.gh")
