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
	"joshdick/onedark.vim",

	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "kyazdani42/nvim-web-devicons", event = "VeryLazy" },

	-- EditorConfig
	{ "gpanders/editorconfig.nvim", event = "VeryLazy" },

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		init = function()
			vim.notify = require("notify")
		end,
	}, -- .config/nvim/ftplugin/plantuml.lua で利用

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		config = conf("cmp"),
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"f3fora/cmp-spell",
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy", "BufReadPre" },
		config = conf("lsp"),
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",

			"nvimdev/lspsaga.nvim",

			"b0o/schemastore.nvim",
		},
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		tag = "legacy",
		opts = {},
	},
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = conf("nvim-lint"),
	},
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		config = conf("conform"),
	},

	-- Debug
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = conf("dap"),
		dependencies = {
			"williamboman/mason.nvim",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
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
			"nvim-telescope/telescope-ghq.nvim",
			{
				"renerocksai/telekasten.nvim",
				config = conf("telekasten"),
				dependencies = {
					{ "renerocksai/calendar-vim" },
				},
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = conf("treesitter"),
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				dependencies = {
					{
						"windwp/nvim-ts-autotag",
					},
				},
			},
			{
				"David-Kunz/treesitter-unit",
				config = conf("treesitter-unit"),
			},
		},
	},
	{
		"kiyoon/treesitter-indent-object.nvim",
		keys = {
			{
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer)",
			},
			{
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer, line-wise)",
			},
			{
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, partial range)",
			},
			{
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, entire range)",
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
			"rapan931/lasterisk.nvim",
			"kevinhwang91/nvim-hlslens",
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
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = conf("lualine"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},
	},
	{
		"gen740/SmoothCursor.nvim",
		event = "VeryLazy",
		config = conf("SmoothCursor"),
	},
	{
		"anuvyklack/fold-preview.nvim",
		event = "VeryLazy",
		config = conf("fold-preview"),
		dependencies = {
			"anuvyklack/pretty-fold.nvim",
		},
	},

	-- Ops
	{
		"lambdalisue/kensaku-search.vim",
		event = "VeryLazy",
		config = conf("kensaku-search"),
		dependencies = {
			"lambdalisue/kensaku.vim",
			"vim-denops/denops.vim",
		},
	},
	{
		"smoka7/hop.nvim",
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
		"hrsh7th/nvim-insx",
		event = "InsertEnter",
		config = conf("insx"),
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
			"kyazdani42/nvim-web-devicons",
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
	{
		"simeji/winresizer",
		event = { "VeryLazy" },
		init = conf("winresizer"),
	},

	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VeryLazy",
		config = conf("neo-tree"),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"kyazdani42/nvim-web-devicons",
			"joshdick/onedark.vim",
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
	{ "aklt/plantuml-syntax", ft = "plantuml" },
	{ "slim-template/vim-slim", ft = "slim" },

	-- Indent
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufNewFile", "BufRead" },
		main = "ibl",
		opts = {},
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
	{
		"lambdalisue/guise.vim",
		event = "VimEnter",
		dependencies = {
			"vim-denops/denops.vim",
		},
	},

	{
		"klen/nvim-config-local",
		event = "VeryLazy",
		config = conf("nvim-config-local"),
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
}, {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "habamax" },
	},
})

vim.cmd.colorscheme("onedark")
