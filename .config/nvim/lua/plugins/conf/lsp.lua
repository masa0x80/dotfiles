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
require("utils").create_autocmd({ "BufEnter" }, {
	callback = function()
		require("lspsaga").config.lightbulb.sign = vim.o.ft ~= "markdown"
	end,
})

local keymap = vim.keymap.set
keymap("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", {})
keymap("n", "gR", "<Cmd>Lspsaga rename<CR>", {})

keymap("n", "<Leader>ca", "<Cmd>Lspsaga code_action<CR>", {})
keymap("n", "gC", "<Cmd>Lspsaga code_action<CR>", {})

keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {})
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {})

-- Setup neovim lua configuration
require("neodev").setup()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup({ ui = { border = "rounded" } })

require("mason-lspconfig").setup()

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
