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
		use("tpope/vim-repeat")
		use("tpope/vim-unimpaired")
		use("kyazdani42/nvim-web-devicons")
		use("MunifTanjim/nui.nvim")

		-- Comment out
		use({
			"numToStr/Comment.nvim",
			event = "BufEnter",
			config = function()
				require("config.comment")
			end,
		})
		use({
			"folke/which-key.nvim",
			event = "BufEnter",
			config = function()
				require("config.which-key")
			end,
		})
		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("config.impatient")
			end,
		})

		-- Colorscheme
		use("joshdick/onedark.vim")

		-- LSP
		use({
			"neoclide/coc.nvim",
			branch = "master",
			run = "yarn install --frozen-lockfile",
			requires = {
				"honza/vim-snippets",
			},
			config = function()
				require("config.coc")
			end,
		})
		use({
			"dense-analysis/ale",
			config = function()
				require("config.ale")
			end,
		})

		-- Debug
		use({
			"puremourning/vimspector",
			event = "BufEnter",
			config = function()
				require("config.vimspector")
			end,
		})

		-- Test
		use({
			"vim-test/vim-test",
			event = "BufEnter",
			config = function()
				require("config.vim-test")
			end,
		})
		use({
			"is0n/jaq-nvim",
			event = "BufEnter",
			config = function()
				require("config.jaq")
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			event = "BufEnter",
			requires = {
				"fannheyward/telescope-coc.nvim",
			},
			config = function()
				require("config.telescope")
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			config = function()
				require("config.treesitter")
			end,
		})
		use({
			"David-Kunz/treesitter-unit",
			event = "BufEnter",
			config = function()
				require("config.treesitter-unit")
			end,
		})
		use({
			"haringsrob/nvim_context_vt",
			event = "BufEnter",
		})

		-- UI
		use({
			"RRethy/vim-illuminate",
			event = "BufEnter",
			config = function()
				require("config.illuminate")
			end,
		})
		use({
			"petertriho/nvim-scrollbar",
			event = "BufEnter",
			config = function()
				require("config.scrollbar")
			end,
		})
		use({
			"kevinhwang91/nvim-hlslens",
			event = "BufEnter",
			config = function()
				require("config.hlslens")
			end,
		})
		use({
			"haya14busa/vim-asterisk",
			event = "BufEnter",
		})
		use({
			"norcalli/nvim-colorizer.lua",
			event = "BufEnter",
			config = function()
				require("config.colorizer")
			end,
		})
		use({
			"mvllow/modes.nvim",
			event = "BufEnter",
			config = function()
				require("config.modes")
			end,
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.lualine")
			end,
		})
		use({
			"kdheepak/tabline.nvim",
			requires = {
				"nvim-lualine/lualine.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("config.tabline")
			end,
		})
		use({
			"b0o/incline.nvim",
			event = "BufLeave",
			config = function()
				require("config.incline")
			end,
		})

		-- Ops
		use({
			"ggandor/lightspeed.nvim",
			event = "BufEnter",
			config = function()
				require("config.lightspeed")
			end,
		})
		use({
			"Bakudankun/BackAndForward.vim",
			event = "BufLeave",
			config = function()
				require("config.BackAndForward")
			end,
		})

		-- Git
		use({
			"tpope/vim-fugitive",
			event = "BufEnter",
		})
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufEnter",
			config = function()
				require("config.gitsigns")
			end,
		})
		use({
			"akinsho/git-conflict.nvim",
			config = function()
				require("config.git-conflict")
			end,
		})

		-- Filer
		use({
			"nvim-neo-tree/neo-tree.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			event = "BufEnter",
			config = function()
				require("config.neo-tree")
			end,
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown", "plantuml" },
			config = function()
				require("config.markdown-preview")
			end,
		})

		-- PlantUML
		use("aklt/plantuml-syntax")

		use("gpanders/editorconfig.nvim") -- EditorConfig
		use("lambdalisue/readablefold.vim") -- Folding
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufEnter",
		}) -- Indent
		use({
			"machakann/vim-sandwich", -- Textobject
			event = "BufEnter",
		}) -- Indent
		-- Prettification
		use({
			"junegunn/vim-easy-align",
			event = "BufEnter",
			config = function()
				require("config.easy-align")
			end,
		})
		use({
			"folke/todo-comments.nvim",
			event = "BufEnter",
			config = function()
				require("config.todo-comments")
			end,
		})
		use({
			"monaqa/dial.nvim",
			event = "BufEnter",
			config = function()
				require("config.dial")
			end,
		})
		use({
			"windwp/nvim-spectre",
			event = "BufEnter",
			config = function()
				require("config.spectre")
			end,
		})
		use("jghauser/mkdir.nvim")
		use({
			"dhruvasagar/vim-table-mode",
			ft = { "markdown" },
		})
		use({
			"danymat/neogen",
			event = "BufEnter",
			config = function()
				require("config.neogen")
			end,
		})
		use({
			"folke/trouble.nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			event = "BufEnter",
			config = function()
				require("config.trouble")
			end,
		})

		use({
			"akinsho/toggleterm.nvim",
			event = "BufEnter",
			config = function()
				require("config.toggleterm")
			end,
		})

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
