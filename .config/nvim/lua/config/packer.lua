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
		-- usein Manager
		use("wbthomason/packer.nvim")

		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
			end,
		})

		use({ "nvim-lua/plenary.nvim", event = "BufEnter" }) -- Useful lua functions used ny lots of plugins
		use({ "nvim-lua/popup.nvim", event = "BufEnter" }) -- An implementation of the Popup API from vim in Neovim
		use({ "MunifTanjim/nui.nvim", event = "BufEnter" })
		use({ "kyazdani42/nvim-web-devicons", event = "BufEnter" })
		use({ "tpope/vim-repeat", event = { "FocusLost", "CursorHold" } })
		use({ "tpope/vim-unimpaired", event = { "FocusLost", "CursorHold" } })
		use({ "gpanders/editorconfig.nvim", event = { "BufEnter" } }) -- EditorConfig

		-- Comment out
		use({
			"numToStr/Comment.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.comment")
			end,
		})
		use({
			"folke/which-key.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.which-key")
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
			event = { "BufEnter" },
			requires = {
				{ "honza/vim-snippets", opt = true },
			},
			wants = { "vim-snippets" },
			config = function()
				require("config.plugins.coc")
			end,
		})
		use({
			"dense-analysis/ale",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.ale")
			end,
		})

		-- Completions
		use({
			"hrsh7th/nvim-cmp",
			module = { "cmp" },
			requires = {
				{ "hrsh7th/cmp-buffer", event = { "FocusLost", "CursorHold" } },
				{ "hrsh7th/cmp-path", event = { "FocusLost", "CursorHold" } },
				{ "hrsh7th/cmp-cmdline", event = { "FocusLost", "CursorHold" } },
			},
			wants = { "cmp-buffer", "cmp-path", "cmp-cmdline" },
			config = function()
				require("config.plugins.cmp")
			end,
		})

		-- Debug
		use({
			"puremourning/vimspector",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.vimspector")
			end,
		})

		-- Test
		use({
			"vim-test/vim-test",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.vim-test")
			end,
		})
		use({
			"is0n/jaq-nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.jaq")
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			event = { "BufEnter" },
			requires = {
				{ "fannheyward/telescope-coc.nvim" },
			},
			config = function()
				require("config.plugins.telescope")
			end,
		})

		use({
			"renerocksai/telekasten.nvim",
			event = "BufEnter",
			requires = { "renerocksai/calendar-vim", opt = true },
			wants = { "calendar-vim" },
			config = function()
				require("config.plugins.telekasten")
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
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.treesitter-unit")
			end,
		})
		use({
			"haringsrob/nvim_context_vt",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.context_vt")
			end,
		})

		-- UI
		use({
			"RRethy/vim-illuminate",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.illuminate")
			end,
		})
		use({
			"petertriho/nvim-scrollbar",
			event = {
				"BufWinEnter",
				"CmdwinLeave",
				"TabEnter",
				"TermEnter",
				"TextChanged",
				"VimResized",
				"WinEnter",
				"WinScrolled",
			},
			config = function()
				require("config.plugins.scrollbar")
			end,
		})
		use({
			"kevinhwang91/nvim-hlslens",
			event = "CursorMoved",
			config = function()
				require("config.plugins.hlslens")
			end,
		})
		use({
			"haya14busa/vim-asterisk",
			event = { "FocusLost", "CursorHold" },
		})
		use({
			"norcalli/nvim-colorizer.lua",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.colorizer")
			end,
		})
		use({
			"mvllow/modes.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.modes")
			end,
		})
		use({
			"kdheepak/tabline.nvim",
			event = { "BufEnter" },
			requires = { "nvim-lualine/lualine.nvim", "kyazdani42/nvim-web-devicons" },
			config = function()
				require("config.plugins.tabline")
			end,
		})
		use({
			"b0o/incline.nvim",
			event = { "FocusLost", "CursorHold" },
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
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.BackAndForward")
			end,
		})

		-- Git
		use({
			"tpope/vim-fugitive",
			event = { "FocusLost", "CursorHold" },
		})
		use({
			"lewis6991/gitsigns.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.gitsigns")
			end,
		})
		use({
			"akinsho/git-conflict.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.git-conflict")
			end,
		})
		use({
			"rhysd/git-messenger.vim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.git-messenger")
			end,
		})

		-- Filer
		use({
			"nvim-neo-tree/neo-tree.nvim",
			event = "BufEnter",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("config.plugins.neo-tree")
			end,
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown", "plantuml" },
			config = function()
				require("config.plugins.markdown-preview")
			end,
		})

		-- PlantUML
		use({
			"aklt/plantuml-syntax",
			event = { "BufEnter" },
		})

		-- slim
		use({ "slim-template/vim-slim", event = { "BufEnter" } })

		-- Folding
		use({ "lambdalisue/readablefold.vim", event = "BufEnter" })
		use({
			"windwp/nvim-autopairs",
			event = { "InsertEnter" },
			config = function()
				require("config.plugins.autopairs")
			end,
		})

		-- Indent
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufEnter" },
			config = function()
				require("config.plugins.indent-blankline")
			end,
		})
		-- Textobject
		use({
			"machakann/vim-sandwich",
			event = { "FocusLost", "CursorHold" },
		})
		-- Prettification
		use({
			"junegunn/vim-easy-align",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins..easy-align")
			end,
		})
		use({
			"monaqa/dial.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.dial")
			end,
		})
		use({
			"windwp/nvim-spectre",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.spectre")
			end,
		})
		use({
			"jghauser/mkdir.nvim",
			event = { "FocusLost", "CursorHold" },
		})
		use({
			"dhruvasagar/vim-table-mode",
			ft = { "markdown" },
		})
		use({
			"danymat/neogen",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.neogen")
			end,
		})
		use({
			"folke/todo-comments.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.todo-comments")
			end,
		})

		use({
			"akinsho/toggleterm.nvim",
			event = { "FocusLost", "CursorHold" },
			config = function()
				require("config.plugins.toggleterm")
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
	pattern = "packer.lua",
	command = "source <afile> | PackerCompile",
})
