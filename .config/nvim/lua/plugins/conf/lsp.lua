local signs = {
	Error = "",
	Warn = "",
	Info = "",
	Hint = "",
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

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	if client.name == "rubocop" or client.name == "terraformls" then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			buffer = bufnr,
			command = "Format",
		})
	end
	if client.name == "eslint" then
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	bashls = {},
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
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	rubocop = {},
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
	},
	code_action = {
		keys = {
			quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
		},
	},
	lightbulb = {
		sign = false,
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

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
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
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

local registry = require("mason-registry")
for _, name in ipairs({ "black", "cspell", "goimports", "hadolint", "shellcheck", "shfmt", "stylua", "tflint" }) do
	local package = registry.get_package(name)
	if not package:is_installed() then
		package:install()
	end
end
