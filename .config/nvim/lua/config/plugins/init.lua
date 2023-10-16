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

	{ "tpope/vim-repeat", event = "UIEnter" },
	{ "tpope/vim-unimpaired", event = "UIEnter" },
	{ "gpanders/editorconfig.nvim", event = "UIEnter" }, -- EditorConfig

	{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },

	-- Colorscheme
	"joshdick/onedark.vim",

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		config = conf("cmp"),
		dependencies = {
			{ "onsails/lspkind.nvim", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
			{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
			{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
			{ "rafamadriz/friendly-snippets", event = "InsertEnter" },
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
			{ "hrsh7th/cmp-cmdline", event = "ModeChanged" },
			{ "f3fora/cmp-spell", event = "InsertEnter" },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "UIEnter", "BufReadPre" },
		config = conf("lsp"),
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", event = "LspAttach" },
			{ "williamboman/mason-lspconfig.nvim", event = "LspAttach" },

			{ "b0o/schemastore.nvim", event = "LspAttach" },

			-- Additional lua configuration, makes nvim stuff amazing
			{ "folke/neodev.nvim", event = "LspAttach" },

			{ "nvimdev/lspsaga.nvim", event = "LspAttach" },
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
		event = "UIEnter",
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
			{
				"nvim-telescope/telescope-ghq.nvim",
				event = "UIEnter",
			},
			{
				"renerocksai/telekasten.nvim",
				event = "UIEnter",
				config = conf("telekasten"),
				dependencies = {
					{ "renerocksai/calendar-vim" },
				},
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				event = "UIEnter",
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "UIEnter",
		build = ":TSUpdate",
		config = conf("treesitter"),
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", event = "UIEnter" },
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "UIEnter",
				dependencies = {
					{
						"windwp/nvim-ts-autotag",
					},
				},
			},
			{
				"David-Kunz/treesitter-unit",
				event = "UIEnter",
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
		event = "UIEnter",
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
			{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },
			{ "SmiteshP/nvim-navic", event = "LspAttach" },
		},
	},
	{
		"gen740/SmoothCursor.nvim",
		event = "UIEnter",
		config = conf("SmoothCursor"),
	},
	{
		"anuvyklack/fold-preview.nvim",
		event = "UIEnter",
		config = conf("fold-preview"),
		dependencies = {
			{ "anuvyklack/pretty-fold.nvim", event = "UIEnter", opts = {} },
		},
	},

	-- Ops
	{
		"lambdalisue/kensaku-search.vim",
		event = "UIEnter",
		config = conf("kensaku-search"),
		dependencies = {
			"lambdalisue/kensaku.vim",
			"vim-denops/denops.vim",
		},
	},
	{
		"smoka7/hop.nvim",
		event = "UIEnter",
		config = conf("hop"),
	},
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
		"hrsh7th/nvim-insx",
		event = "InsertEnter",
		config = conf("insx"),
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
		dependencies = {
			{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },
		},
	},
	{
		"tyru/open-browser.vim",
		event = "UIEnter",
		config = conf("open-browser"),
	},

	-- Git
	{
		"tpope/vim-fugitive",
		event = "UIEnter",
	},
	{
		"ruifm/gitlinker.nvim",
		event = "UIEnter",
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
		event = { "UIEnter" },
		init = conf("winresizer"),
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
			{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },
			{ "joshdick/onedark.vim", event = "UIEnter" },
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
		event = "UIEnter",
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
