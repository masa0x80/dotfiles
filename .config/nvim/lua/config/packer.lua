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
		use("tpope/vim-repeat")
		use("tpope/vim-unimpaired")
		use("kyazdani42/nvim-web-devicons")
		use("MunifTanjim/nui.nvim")

		-- Comment out
		use({
			"numToStr/Comment.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.comment")
			end,
		})
		use({
			"folke/which-key.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.which-key")
			end,
		})
		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("config.plugins.impatient")
			end,
		})

		-- Colorscheme
		use({
			"folke/tokyonight.nvim",
			config = function()
				require("config.plugins.colorscheme")
			end,
		})

		-- LSP
		use({
			"neoclide/coc.nvim",
			branch = "master",
			run = "yarn install --frozen-lockfile",
			requires = {
				"honza/vim-snippets",
			},
			config = function()
				require("config.plugins.coc")
			end,
		})
		use({
			"dense-analysis/ale",
			config = function()
				require("config.plugins.ale")
			end,
		})

		-- Completions
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-buffer", opt = true },
				{ "hrsh7th/cmp-path", opt = true },
				{ "hrsh7th/cmp-cmdline", opt = true },
			},
			event = "BufEnter",
			wants = { "cmp-buffer", "cmp-path", "cmp-cmdline" },
			config = function()
				require("config.plugins.cmp")
			end,
		})

		-- Debug
		use({
			"puremourning/vimspector",
			event = "BufEnter",
			config = function()
				require("config.plugins.vimspector")
			end,
		})

		-- Test
		use({
			"vim-test/vim-test",
			event = "BufEnter",
			config = function()
				require("config.plugins.vim-test")
			end,
		})
		use({
			"is0n/jaq-nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.jaq")
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"fannheyward/telescope-coc.nvim",
				{
					"nvim-telescope/telescope-frecency.nvim",
					requires = { "kkharji/sqlite.lua" },
				},
				{
					"renerocksai/telekasten.nvim",
					requires = { "renerocksai/calendar-vim" },
					config = function()
						require("config.plugins.telekasten")
					end,
				},
			},
			event = "BufEnter",
			config = function()
				require("config.plugins.telescope")
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			config = function()
				require("config.plugins.treesitter")
			end,
		})
		use({
			"David-Kunz/treesitter-unit",
			event = "BufEnter",
			config = function()
				require("config.plugins.treesitter-unit")
			end,
		})
		use({
			"haringsrob/nvim_context_vt",
			event = "BufEnter",
			config = function()
				require("config.plugins.context_vt")
			end,
		})

		-- UI
		use({
			"RRethy/vim-illuminate",
			event = "BufEnter",
			config = function()
				require("config.plugins.illuminate")
			end,
		})
		use({
			"petertriho/nvim-scrollbar",
			event = "BufEnter",
			config = function()
				require("config.plugins.scrollbar")
			end,
		})
		use({
			"kevinhwang91/nvim-hlslens",
			event = "BufEnter",
			config = function()
				require("config.plugins.hlslens")
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
				require("config.plugins.colorizer")
			end,
		})
		use({
			"mvllow/modes.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.modes")
			end,
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("config.plugins.lualine")
			end,
		})
		use({
			"kdheepak/tabline.nvim",
			requires = {
				"nvim-lualine/lualine.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("config.plugins.tabline")
			end,
		})
		use({
			"b0o/incline.nvim",
			event = "BufLeave",
			config = function()
				require("config.plugins.incline")
			end,
		})

		-- Ops
		use({
			"phaazon/hop.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.hop")
			end,
		})
		use({
			"Bakudankun/BackAndForward.vim",
			event = "BufLeave",
			config = function()
				require("config.plugins.BackAndForward")
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
				require("config.plugins.gitsigns")
			end,
		})
		use({
			"akinsho/git-conflict.nvim",
			config = function()
				require("config.plugins.git-conflict")
			end,
		})
		use({
			"rhysd/git-messenger.vim",
			event = "BufEnter",
			config = function()
				require("config.plugins.git-messenger")
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
				require("config.plugins.neo-tree")
			end,
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			config = function()
				require("config.plugins.markdown-preview")
			end,
		})

		-- PlantUML
		use("aklt/plantuml-syntax")

		use("gpanders/editorconfig.nvim") -- EditorConfig
		use("lambdalisue/readablefold.vim") -- Folding
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("config.plugins.autopairs")
			end,
		})

		-- Indent
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.indent-blankline")
			end,
		})
		-- Textobject
		use({
			"machakann/vim-sandwich",
			jjevent = "BufEnter",
		})
		-- Prettification
		use({
			"junegunn/vim-easy-align",
			event = "BufEnter",
			config = function()
				require("config.plugins..easy-align")
			end,
		})
		use({
			"monaqa/dial.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.dial")
			end,
		})
		use({
			"windwp/nvim-spectre",
			event = "BufEnter",
			config = function()
				require("config.plugins.spectre")
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
				require("config.plugins.neogen")
			end,
		})
		use({
			"folke/todo-comments.nvim",
			config = function()
				require("config.plugins.todo-comments")
			end,
		})

		use({
			"akinsho/toggleterm.nvim",
			event = "BufEnter",
			config = function()
				require("config.plugins.toggleterm")
			end,
		})

		use("slim-template/vim-slim")

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
	pattern = "packer.lua",
	command = "source <afile> | PackerCompile",
})
