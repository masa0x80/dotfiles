local signs = {
	Error = " ",
	Warn = " ",
	Info = "",
	Hint = " ",
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

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<Leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<Leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<Leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

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
	eslint = {},
	tsserver = {
		init_options = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
	solargraph = {
		settings = {
			solargraph = {
				diagnostics = false,
			},
		},
	},
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
	jdtls = {},
}

local saga = require("lspsaga")
saga.setup({
	ui = {
		theme = "round",
		border = "rounded",
	},
	symbol_in_winbar = {
		show_file = false,
	},
	finder = {
		quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
	},
	code_action = {
		keys = {
			quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
		},
	},
	preview = {
		lines_avobe = 9999,
		lines_below = 9999,
	},
	scroll_preview = {
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
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
