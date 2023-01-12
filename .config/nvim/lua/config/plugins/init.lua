local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function conf(name)
	return function()
		require(string.format("config.plugins.%s", name))
	end
end

require("lazy").setup({
	"folke/lazy.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",

	{ "tpope/vim-repeat", event = "VimEnter" },
	{ "tpope/vim-unimpaired", event = "UIEnter" },
	{ "gpanders/editorconfig.nvim", event = "UIEnter" }, -- EditorConfig

	{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },

	-- Colorscheme
	{
		"joshdick/onedark.vim",
		event = "VimEnter",
		config = conf("colorscheme"),
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "UIEnter",
		config = conf("cmp"),
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to usew
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "f3fora/cmp-spell" },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = "UIEnter",
		config = conf("lsp"),
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{ "b0o/schemastore.nvim" },

			-- Additional lua configuration, makes nvim stuff amazing
			{ "folke/neodev.nvim" },

			{ "tami5/lspsaga.nvim" },
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
		event = "UIEnter",
		config = conf("null-ls"),
		dependencies = {
			{ "lukas-reineke/lsp-format.nvim" },
		},
	},

	-- Debug
	{
		"mfussenegger/nvim-dap",
		event = "UIEnter",
		config = conf("dap"),
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
		},
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				-- NOTE: Fix version ref. https://github.com/mxsdev/nvim-dap-vscode-js/issues/23
				version = "v1.74.1",
				pin = true,
				build = "npm install --legacy-peer-deps && npm run compile",
			},
		},
	},

	-- Test
	{
		"vim-test/vim-test",
		event = "UIEnter",
		config = conf("vim-test"),
	},
	{
		"is0n/jaq-nvim",
		event = "UIEnter",
		config = conf("jaq"),
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "UIEnter",
		config = conf("telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ghq.nvim",
		},
	},
	{
		"renerocksai/telekasten.nvim",
		event = "UIEnter",
		config = conf("telekasten"),
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "renerocksai/calendar-vim" },
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "UIEnter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				config = conf("treesitter"),
			},
		},
	},
	{
		"David-Kunz/treesitter-unit",
		event = "UIEnter",
		config = conf("treesitter-unit"),
	},

	-- UI
	{
		"folke/which-key.nvim",
		event = "UIEnter",
		config = conf("which-key"),
	},
	{
		"petertriho/nvim-scrollbar",
		event = "UIEnter",
		config = conf("nvim-scrollbar"),
		dependencies = {
			{ "rapan931/lasterisk.nvim" },
			{ "kevinhwang91/nvim-hlslens" },
		},
	},
	{
		"haringsrob/nvim_context_vt",
		event = "UIEnter",
		config = conf("context_vt"),
	},
	{
		"RRethy/vim-illuminate",
		event = "UIEnter",
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "UIEnter",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("lualine"),
		dependencies = {
			{ "kdheepak/tabline.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-lua/lsp-status.nvim" },
		},
	},
	{
		"b0o/incline.nvim",
		event = "UIEnter",
		config = conf("incline"),
	},
	{
		"folke/noice.nvim",
		event = "UIEnter",
		config = conf("noice"),
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{ "rcarriga/nvim-notify" },
		},
	},

	-- Ops
	{
		"Bakudankun/BackAndForward.vim",
		event = "UIEnter",
		config = conf("BackAndForward"),
	},
	{
		"windwp/nvim-spectre",
		event = "UIEnter",
		config = conf("spectre"),
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"jghauser/mkdir.nvim",
		event = "UIEnter",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"monaqa/dial.nvim",
		event = "UIEnter",
		config = conf("dial"),
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
	},
	{
		"danymat/neogen",
		event = "UIEnter",
		config = conf("neogen"),
	},
	{
		"junegunn/vim-easy-align",
		event = "UIEnter",
		config = conf("easy-align"),
	},
	{
		"folke/todo-comments.nvim",
		event = "UIEnter",
		config = conf("todo-comments"),
	},
	{
		"folke/trouble.nvim",
		event = "UIEnter",
		config = conf("trouble"),
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},

	-- Git
	{
		"tpope/vim-fugitive",
		event = "UIEnter",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "UIEnter",
		config = conf("gitsigns"),
	},
	{
		"akinsho/git-conflict.nvim",
		event = "UIEnter",
		config = conf("git-conflict"),
	},
	{
		"rhysd/git-messenger.vim",
		event = "UIEnter",
		config = conf("git-messenger"),
	},

	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "UIEnter",
		config = conf("neo-tree"),
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "MunifTanjim/nui.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
		},
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown", "plantuml" },
		config = conf("markdown-preview"),
	},

	-- Syntax
	{ "aklt/plantuml-syntax", event = "UIEnter" },
	{ "slim-template/vim-slim", event = "UIEnter" },

	-- Folding
	{ "lambdalisue/readablefold.vim", event = "UIEnter" },

	-- Indent
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "UIEnter",
		config = conf("indent-blankline"),
	},

	-- Textobject
	{
		"machakann/vim-sandwich",
		event = "UIEnter",
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "UIEnter",
		config = conf("comment"),
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		event = "UIEnter",
		config = conf("toggleterm"),
	},
}, {
	default = {
		lazy = true,
	},
})
