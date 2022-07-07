local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup({
	function(use)
		use("wbthomason/packer.nvim") -- usein Manager

		use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
		use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
		use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
		use("numToStr/Comment.nvim") -- Comment out
		use("tpope/vim-repeat")
		use("tpope/vim-unimpaired")
		use("kyazdani42/nvim-web-devicons")
		use("MunifTanjim/nui.nvim")
		use("folke/which-key.nvim")
		use("lewis6991/impatient.nvim")

		-- Colorscheme
		use("joshdick/onedark.vim")

		-- Cmp plugins
		use("hrsh7th/nvim-cmp") -- The completion plugin
		use("hrsh7th/cmp-buffer") -- buffer completions
		use("hrsh7th/cmp-path") -- path completions
		use("hrsh7th/cmp-cmdline") -- cmdline completions
		use("saadparwaiz1/cmp_luasnip") -- snippet completions
		use("hrsh7th/cmp-nvim-lsp")
		use("f3fora/cmp-spell")

		-- Snippets
		use("L3MON4D3/LuaSnip") --snippet engine
		use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

		-- LSP
		use("neovim/nvim-lspconfig") -- enable LSP
		use("williamboman/nvim-lsp-installer") -- simple to use language server installer
		use("tami5/lspsaga.nvim")
		use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
		use("j-hui/fidget.nvim")
		use("dense-analysis/ale")
		use("b0o/schemastore.nvim")
		use("WhoIsSethDaniel/toggle-lsp-diagnostics.nvim")

		-- Debug
		use("puremourning/vimspector")

		-- Test
		use("vim-test/vim-test")
		use("is0n/jaq-nvim")

		-- Telescope
		use("nvim-telescope/telescope.nvim")

		-- Treesitter
		use("nvim-treesitter/nvim-treesitter")
		use("David-Kunz/treesitter-unit")
		use("haringsrob/nvim_context_vt")

		-- UI
		use("RRethy/vim-illuminate")
		use("petertriho/nvim-scrollbar")
		use("kevinhwang91/nvim-hlslens")
		use("haya14busa/vim-asterisk")
		use("norcalli/nvim-colorizer.lua")
		use("mvllow/modes.nvim")
		use("nvim-lualine/lualine.nvim")
		use("b0o/incline.nvim")

		-- Ops
		use("ggandor/lightspeed.nvim")
		use("Bakudankun/BackAndForward.vim")

		-- Git
		use("tpope/vim-fugitive")
		use("lewis6991/gitsigns.nvim")
		use("tanvirtin/vgit.nvim")
		use("akinsho/git-conflict.nvim")

		-- Filer
		use("nvim-neo-tree/neo-tree.nvim")

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown", "plantuml" },
		})

		-- PlantUML
		use("aklt/plantuml-syntax")

		use("gpanders/editorconfig.nvim") -- EditorConfig
		use("lambdalisue/readablefold.vim") -- Folding
		use("lukas-reineke/indent-blankline.nvim") -- Indent
		use("machakann/vim-sandwich") -- Textobject
		use("junegunn/vim-easy-align") -- Prettification
		use("folke/todo-comments.nvim")
		use("cohama/lexima.vim")
		use("monaqa/dial.nvim")
		use("windwp/nvim-spectre")
		use("jghauser/mkdir.nvim")
		use("dhruvasagar/vim-table-mode")

		use("akinsho/toggleterm.nvim")

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			packer.sync()
		end
	end,
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "_",
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})
