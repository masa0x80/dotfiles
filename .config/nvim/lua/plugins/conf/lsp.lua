local signs = {
	Error = "",
	Warn = "",
	Info = "",
	Hint = "",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		source = true,
	},
})

local icon = require("config.icon")
local navic = require("nvim-navic")
navic.setup({
	icons = {
		File = icon.File .. " ",
		Module = icon.Module .. " ",
		Namespace = icon.Namespace .. " ",
		Package = icon.Package .. " ",
		Class = icon.Class .. " ",
		Method = icon.Method .. " ",
		Property = icon.Property .. " ",
		Field = icon.Field .. " ",
		Constructor = icon.Constructor .. " ",
		Enum = icon.Enum .. " ",
		Interface = icon.Interface .. " ",
		Function = icon.Function .. " ",
		Variable = icon.Variable .. " ",
		Constant = icon.Constant .. " ",
		String = icon.String .. " ",
		Number = icon.Number .. " ",
		Boolean = icon.Boolean .. " ",
		Array = icon.Array .. " ",
		Object = icon.Object .. " ",
		Key = icon.Key .. " ",
		Null = icon.Null .. " ",
		EnumMember = icon.EnumMember .. " ",
		Struct = icon.Struct .. " ",
		Event = icon.Event .. " ",
		Operator = icon.Operator .. " ",
		TypeParameter = icon.TypeParameter .. " ",
	},
	lsp = {
		auto_attach = true,
	},
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("gd", vim.lsp.buf.definition, "[GD] Goto Definition")
	nmap("gr", require("telescope.builtin").lsp_references, "[GR] Goto References")
	nmap("gI", vim.lsp.buf.implementation, "[GI] Goto Implementation")
	nmap("<Leader>D", vim.lsp.buf.type_definition, "[D] Type Definition")
	nmap("<Leader>ds", require("telescope.builtin").lsp_document_symbols, "[DS] Document Symbols")
	nmap("<Leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[WS] Workspace Symbols")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[GD] Goto Declaration")

	-- Setup hover keymap
	nmap("K", require("hover").hover, "hover.nvim")
	nmap("gK", require("hover").hover_select, "hover.nvim (select)")
	nmap("<C-p>", function()
		require("hover").hover_switch("previous")
	end, "hover.nvim (previous source)")
	nmap("<C-n>", function()
		require("hover").hover_switch("next")
	end, "hover.nvim (next source)")

	-- Mouse support
	vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })

	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		group = "_",
		callback = function()
			require("hover").hover()
		end,
	})

	if vim.g.formatter_enabled then
		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })

		if client.name == "rubocop" or client.name == "terraformls" then
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				buffer = bufnr,
				command = "Format",
			})
		elseif client.name == "eslint" then
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end
	end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	bashls = {},
	clangd = {},
	dockerls = {},
	eslint = {},
	gopls = {},
	jdtls = {},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	kotlin_language_server = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	marksman = {},
	solargraph = {
		settings = {
			solargraph = {
				diagnostics = false,
			},
		},
	},
	stylelint_lsp = {},
	tailwindcss = {},
	terraformls = {},
	tsserver = {
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
}

local saga = require("lspsaga")
saga.setup({
	ui = {
		border = "rounded",
		code_action = "",
	},
	code_action = {
		keys = {
			quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
		},
	},
	lightbulb = {
		virtual_text = false,
	},
	finder = {
		default = "def+ref+imp",
		keys = {
			shuttle = { "[w", "<C-l>", "<C-h>" },
			toggle_or_open = { "o", "<CR>" },
			quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
			close = { "<C-c>k", "c" },
		},
	},
	preview = {
		lines_above = 9999,
		lines_below = 9999,
	},
	symbol_in_winbar = {
		enable = false,
	},
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = "_",
	callback = function()
		require("lspsaga").config.lightbulb.sign = vim.o.ft ~= "markdown"
	end,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "gh", "<Cmd>Lspsaga finder<CR>", opts)
keymap("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", opts)

keymap("n", "<Leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)

keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup({ ui = { border = "rounded" } })

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		local args = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
		if server_name == "clangd" then
			args.capabilities.offsetEncoding = { "utf-16" }
			args.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
		end
		require("lspconfig")[server_name].setup(args)
	end,
})

require("hover").setup({
	init = function()
		-- Require providers
		require("hover.providers.lsp")
		require("hover.providers.fold_preview")
		-- require('hover.providers.gh')
		-- require('hover.providers.gh_user')
		-- require('hover.providers.jira')
		-- require('hover.providers.dap')
		-- require('hover.providers.man')
		-- require('hover.providers.dictionary')
	end,
	preview_opts = {
		border = "single",
	},
	-- Whether the contents of a currently open hover window should be moved
	-- to a :h preview-window when pressing the hover keymap.
	preview_window = false,
	title = true,
	mouse_providers = {
		"LSP",
	},
	mouse_delay = 1000,
})

-- https://github.com/williamboman/mason.nvim/issues/1309#issuecomment-1555018732
local packages = {
	"black",
	"cspell",
	"goimports",
	"hadolint",
	"shellcheck",
	"shfmt",
	"stylua",
	"tflint",
}
local registry = require("mason-registry")
registry.refresh(function()
	for _, pkg_name in ipairs(packages) do
		local pkg = registry.get_package(pkg_name)
		if not pkg:is_installed() then
			pkg:install()
		end
	end
end)
