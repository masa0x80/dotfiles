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
		local path = string.format(vim.fn.expand("$HOME") .. "/.config.local/nvim/lua/config/plugins/%s.lua", name)
		if vim.fn.filereadable(path) == 1 then
			vim.fn.execute("luafile " .. path)
		else
			require(string.format("config.plugins.%s", name))
		end
	end
end

require("lazy").setup({
	"folke/lazy.nvim",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"rcarriga/nvim-notify", -- .config/nvim/ftplugin/plantuml.lua で利用

	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "gpanders/editorconfig.nvim", event = "VeryLazy" }, -- EditorConfig

	{ "kyazdani42/nvim-web-devicons", event = "VeryLazy" },

	-- Colorscheme
	{
		"joshdick/onedark.vim",
		lazy = true,
		config = conf("color"),
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		config = conf("cmp"),
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
			{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
			{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
			{ "rafamadriz/friendly-snippets", event = "InsertEnter" }, -- a bunch of snippets to usew
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
			{ "hrsh7th/cmp-cmdline", event = "ModeChanged" },
			{ "f3fora/cmp-spell", event = "InsertEnter" },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = conf("lsp"),
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", event = "LspAttach" },
			{ "williamboman/mason-lspconfig.nvim", event = "LspAttach" },

			{ "b0o/schemastore.nvim", event = "LspAttach" },

			-- Additional lua configuration, makes nvim stuff amazing
			{ "folke/neodev.nvim", event = "LspAttach" },

			{ "glepnir/lspsaga.nvim", event = "LspAttach" },

			{ "nvim-lua/lsp-status.nvim", event = "LspAttach" },
			{ "SmiteshP/nvim-navic", event = "LspAttach" },
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
		event = "LspAttach",
		config = conf("null-ls"),
		dependencies = {
			{ "lukas-reineke/lsp-format.nvim", event = "LspAttach" },
		},
	},

	-- Debug
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = conf("dap"),
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
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
		},
	},

	-- Test
	{
		"is0n/jaq-nvim",
		event = "VeryLazy",
		config = conf("jaq"),
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = conf("telescope"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ghq.nvim",
				event = "VeryLazy",
			},
			{
				"renerocksai/telekasten.nvim",
				event = "VeryLazy",
				config = conf("telekasten"),
				dependencies = {
					{ "renerocksai/calendar-vim" },
				},
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = conf("treesitter"),
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "VeryLazy",
				dependencies = {
					{
						"windwp/nvim-ts-autotag",
					},
				},
			},
			{
				"David-Kunz/treesitter-unit",
				event = "VeryLazy",
				config = conf("treesitter-unit"),
			},
		},
	},

	-- UI
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = conf("which-key"),
	},
	{
		"petertriho/nvim-scrollbar",
		event = { "BufNewFile", "BufRead" },
		config = conf("nvim-scrollbar"),
		dependencies = {
			{ "rapan931/lasterisk.nvim", event = { "BufNewFile", "BufRead" } },
			{ "kevinhwang91/nvim-hlslens", event = { "BufNewFile", "BufRead" } },
		},
	},
	{
		"haringsrob/nvim_context_vt",
		event = { "BufNewFile", "BufRead" },
		config = conf("context_vt"),
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufNewFile", "BufRead" },
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("lualine"),
		dependencies = {
			{ "kyazdani42/nvim-web-devicons", lazy = true },
			{
				"kdheepak/tabline.nvim",
				event = { "CursorHold", "CursorMoved", "ModeChanged" },
			},
			{ "nvim-lua/lsp-status.nvim", event = "LspAttach" },
		},
	},
	{
		"b0o/incline.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("incline"),
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = conf("noice"),
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- Ops
	{
		"phaazon/hop.nvim",
		event = "VeryLazy",
		config = conf("hop"),
	},
	{
		"Bakudankun/BackAndForward.vim",
		event = "VeryLazy",
		config = conf("BackAndForward"),
	},
	{
		"windwp/nvim-spectre",
		event = "VeryLazy",
		config = conf("spectre"),
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"jghauser/mkdir.nvim",
		event = "VeryLazy",
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
		event = "VeryLazy",
		config = conf("dial"),
	},
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
	},
	{
		"danymat/neogen",
		event = "VeryLazy",
		config = conf("neogen"),
	},
	{
		"junegunn/vim-easy-align",
		event = "VeryLazy",
		config = conf("easy-align"),
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = conf("todo-comments"),
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = conf("trouble"),
		dependencies = {
			{ "kyazdani42/nvim-web-devicons", lazy = true },
		},
	},
	{
		"tyru/open-browser.vim",
		event = "VeryLazy",
		config = conf("open-browser"),
	},

	-- Git
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{
		"ruifm/gitlinker.nvim",
		event = "VeryLazy",
		config = conf("gitlinker"),
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufNewFile", "BufRead" },
		config = conf("gitsigns"),
	},
	{
		"akinsho/git-conflict.nvim",
		event = { "BufNewFile", "BufRead" },
		config = conf("git-conflict"),
	},
	{
		"rhysd/git-messenger.vim",
		event = { "BufNewFile", "BufRead" },
		config = conf("git-messenger"),
	},

	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- `VeryLazy` だとちらつくので `UIEnter` にする
		event = "UIEnter",
		config = conf("neo-tree"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{ "kyazdani42/nvim-web-devicons", lazy = true },
			{ "joshdick/onedark.vim", lazy = true },
		},
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown", "mermaid", "plantuml" },
		config = conf("markdown-preview"),
	},

	-- Syntax
	{ "aklt/plantuml-syntax" },
	{ "slim-template/vim-slim" },

	-- Folding
	{
		"lambdalisue/readablefold.vim",
		event = { "BufNewFile", "BufRead" },
	},
	-- Indent
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufNewFile", "BufRead" },
		config = conf("indent-blankline"),
	},

	-- Textobject
	{
		"machakann/vim-sandwich",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("comment"),
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("toggleterm"),
	},
}, {
	default = {
		lazy = true,
	},
})
