vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		prefix = "",
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
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

	-- Setup hover keymap
	nmap("K", function()
		local line = vim.api.nvim_get_current_line()
		local pattern = "!%[%S*%]%(([^%)]+)%)"
		local startIndex = 1
		local _, _, path = string.find(line, pattern, startIndex)
		if path ~= nil then
			require("config.utils").preview(vim.fn.expand("%:p:h") .. "/" .. path)
		else
			require("hover").hover()
		end
	end, "open the file or hover.nvim")
	nmap("gK", require("hover").hover_select, "hover.nvim (select)")
	nmap("[h", function()
		require("hover").hover_switch("previous")
	end, "hover.nvim (previous source)")
	nmap("]h", function()
		require("hover").hover_switch("next")
	end, "hover.nvim (next source)")

	-- Mouse support
	vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })

	-- NOTE: 意図しない時（diagnosticsを見ている時とか）に hover() が発火してしまうのでコメントアウト
	-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
	-- 	group = "_",
	-- 	callback = function()
	-- 		require("hover").hover()
	-- 	end,
	-- })

	if vim.g.formatter_enabled then
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

	-- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
	ts_ls = {
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
keymap("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", opts)

keymap("n", "<Leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)

keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

-- Setup neovim lua configuration
require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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
		-- XXX: settingsと並列に並べるとts_lsがうまく動く
		if servers[server_name] ~= nil then
			for k, v in pairs(servers[server_name]) do
				args[k] = v
			end
		end
		if server_name == "clangd" then
			args.capabilities.offsetEncoding = { "utf-16" }
			args.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
		end
		require("lspconfig")[server_name].setup(args)
	end,
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
