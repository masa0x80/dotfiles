local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local function conf(name)
	return string.format('require("config.plugins.%s")', name)
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")
packer.startup({
	function(use)
		-- Plugin manager
		use("wbthomason/packer.nvim")

		use({ "nvim-lua/plenary.nvim", opt = true }) -- Useful lua functions used ny lots of plugins
		use({ "MunifTanjim/nui.nvim", opt = true })
		use({ "kyazdani42/nvim-web-devicons", opt = true })
		use({ "tpope/vim-repeat", event = "UIEnter" })
		use({ "tpope/vim-unimpaired", event = "UIEnter" })
		use({ "gpanders/editorconfig.nvim", event = "UIEnter" }) -- EditorConfig

		-- Colorscheme
		use({
			"joshdick/onedark.vim",
			config = conf("colorscheme"),
		})

		-- Completions
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "L3MON4D3/LuaSnip" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to usew
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "f3fora/cmp-spell" },
			},
			config = conf("cmp"),
		})

		use({ -- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			event = "UIEnter",
			requires = {
				-- Automatically install LSPs to stdpath for neovim
				{ "williamboman/mason.nvim", opt = true },
				{ "williamboman/mason-lspconfig.nvim", opt = true },

				{ "b0o/schemastore.nvim", opt = true },

				-- Additional lua configuration, makes nvim stuff amazing
				{ "folke/neodev.nvim", opt = true },

				{ "tami5/lspsaga.nvim", opt = true },
			},
			wants = {
				"mason.nvim",
				"mason-lspconfig.nvim",
				"schemastore.nvim",
				"neodev.nvim",
				"lspsaga.nvim",
			},
			config = conf("lsp"),
		})
		use({
			"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
			requires = {
				{ "lukas-reineke/lsp-format.nvim", opt = true },
			},
			wants = { "lsp-format.nvim" },
			event = "UIEnter",
			config = conf("null-ls"),
		})

		-- Debug
		use({
			"mfussenegger/nvim-dap",
			event = "UIEnter",
			requires = {
				{ "williamboman/mason.nvim", opt = true },
				{ "rcarriga/nvim-dap-ui", opt = true },
				{ "theHamsta/nvim-dap-virtual-text", opt = true },
				{
					"mxsdev/nvim-dap-vscode-js",
					opt = true,
					requires = {
						{
							"microsoft/vscode-js-debug",
							-- NOTE: Fix version ref. https://github.com/mxsdev/nvim-dap-vscode-js/issues/23
							tag = "v1.74.1",
							lock = true,
							opt = true,
							run = "npm install --legacy-peer-deps && npm run compile",
						},
					},
					wants = { "vscode-js-debug" },
				},
			},
			wants = {
				"mason.nvim",
				"nvim-dap-ui",
				"nvim-dap-virtual-text",
				"nvim-dap-vscode-js",
			},
			config = conf("dap"),
		})

		-- Test
		use({
			"vim-test/vim-test",
			event = "UIEnter",
			config = conf("vim-test"),
		})
		use({
			"is0n/jaq-nvim",
			event = "UIEnter",
			config = conf("jaq"),
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			event = "UIEnter",
			requires = { "nvim-lua/plenary.nvim", opt = true },
			wants = { "plenary.nvim" },
			config = conf("telescope"),
		})
		use({
			"renerocksai/telekasten.nvim",
			event = "UIEnter",
			requires = {
				{ "nvim-telescope/telescope.nvim", opt = true },
				{ "renerocksai/calendar-vim", opt = true },
			},
			wants = { "telescope.nvim", "calendar-vim" },
			config = conf("telekasten"),
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "UIEnter",
			requires = {
				{
					"nvim-treesitter/nvim-treesitter",
					opt = true,
					run = ":TSUpdate",
					config = conf("treesitter"),
				},
			},
			wants = "nvim-treesitter",
		})
		use({
			"David-Kunz/treesitter-unit",
			event = "UIEnter",
			config = conf("treesitter-unit"),
		})

		-- UI
		use({
			"folke/which-key.nvim",
			event = "UIEnter",
			config = conf("which-key"),
		})
		use({
			"petertriho/nvim-scrollbar",
			event = "UIEnter",
			requires = {
				{ "rapan931/lasterisk.nvim", opt = true },
				{ "kevinhwang91/nvim-hlslens", opt = true },
			},
			wants = { "lasterisk.nvim", "nvim-hlslens" },
			config = conf("nvim-scrollbar"),
		})
		use({
			"haringsrob/nvim_context_vt",
			event = "UIEnter",
			wants = { "nvim-treesitter" },
			config = conf("context_vt"),
		})
		use({
			"RRethy/vim-illuminate",
			event = "UIEnter",
		})
		use({
			"norcalli/nvim-colorizer.lua",
			event = "UIEnter",
			config = 'require("colorizer").setup()',
		})
		use({
			"nvim-lualine/lualine.nvim",
			event = "UIEnter",
			requires = {
				{ "kyazdani42/nvim-web-devicons", opt = true },
				{ "nvim-lua/lsp-status.nvim", opt = true },
			},
			wants = { "nvim-web-devicons", "lsp-status.nvim" },
			config = conf("lualine"),
		})
		use({
			"b0o/incline.nvim",
			event = "UIEnter",
			config = conf("incline"),
		})
		use({
			"folke/noice.nvim",
			event = "UIEnter",
			requires = {
				{ "MunifTanjim/nui.nvim", opt = true },
				{ "rcarriga/nvim-notify", opt = true },
			},
			wants = { "nui.nvim", "nvim-notify" },
			config = conf("noice"),
		})

		-- Ops
		use({
			"Bakudankun/BackAndForward.vim",
			event = "UIEnter",
			config = conf("BackAndForward"),
		})
		use({
			"windwp/nvim-spectre",
			event = "UIEnter",
			requires = { "nvim-lua/plenary.nvim", opt = true },
			wants = { "plenary.nvim" },
			config = conf("spectre"),
		})
		use({
			"jghauser/mkdir.nvim",
			event = "UIEnter",
		})
		use({
			"dhruvasagar/vim-table-mode",
			ft = { "markdown" },
		})
		use({
			"danymat/neogen",
			event = "UIEnter",
			wants = { "nvim-treesitter" },
			config = conf("neogen"),
		})
		use({
			"folke/todo-comments.nvim",
			event = "UIEnter",
			wants = { "plenary.nvim" },
			config = conf("todo-comments"),
		})
		use({
			"folke/trouble.nvim",
			event = "UIEnter",
			requires = { "kyazdani42/nvim-web-devicons" },
			wants = { "nvim-web-devicons" },
			config = conf("trouble"),
		})

		-- Git
		use({
			"tpope/vim-fugitive",
			event = "UIEnter",
		})
		use({
			"lewis6991/gitsigns.nvim",
			event = "UIEnter",
			config = conf("gitsigns"),
		})
		use({
			"akinsho/git-conflict.nvim",
			event = "UIEnter",
			config = conf("git-conflict"),
		})
		use({
			"rhysd/git-messenger.vim",
			event = "UIEnter",
			config = conf("git-messenger"),
		})

		-- Filer
		use({
			"nvim-neo-tree/neo-tree.nvim",
			event = "UIEnter",
			requires = {
				{ "nvim-lua/plenary.nvim", opt = true },
				{ "MunifTanjim/nui.nvim", opt = true },
				{ "kyazdani42/nvim-web-devicons", opt = true },
			},
			wants = { "plenary.nvim", "nui.nvim", "nvim-web-devicons" },
			config = conf("neo-tree"),
		})

		-- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown", "plantuml" },
			config = conf("markdown-preview"),
		})

		-- PlantUML
		use({
			"aklt/plantuml-syntax",
			event = "UIEnter",
		})

		-- slim
		use({ "slim-template/vim-slim", event = "UIEnter" })

		-- Folding
		use({ "lambdalisue/readablefold.vim", event = "UIEnter" })
		use({
			"windwp/nvim-autopairs",
			event = { "InsertEnter" },
			config = 'require("nvim-autopairs").setup()',
		})

		-- Indent
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "UIEnter",
			config = conf("indent-blankline"),
		})
		-- Textobject
		use({
			"machakann/vim-sandwich",
			event = "UIEnter",
		})
		-- Prettification
		use({
			"junegunn/vim-easy-align",
			event = "UIEnter",
			config = conf("easy-align"),
		})
		use({
			"monaqa/dial.nvim",
			event = "UIEnter",
			config = conf("dial"),
		})

		-- Comment out
		use({
			"numToStr/Comment.nvim",
			event = "UIEnter",
			config = conf("comment"),
		})

		use({
			"akinsho/toggleterm.nvim",
			event = "UIEnter",
			config = conf("toggleterm"),
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			packer.sync()
		end
	end,
	config = {
		-- Have packer use a popup window
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if packer_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "_",
	pattern = "init.lua",
	command = "source <afile> | PackerCompile",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "_",
	pattern = "init.lua",
	command = "echom 'xxx'",
})

vim.keymap.set("n", "<Leader>ps", "<Cmd>PackerSync<CR>", { noremap = true, silent = true, desc = "PackerSync" })
