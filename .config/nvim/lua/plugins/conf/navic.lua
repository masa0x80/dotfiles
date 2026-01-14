local lspkind = require("lspkind")
local navic = require("nvim-navic")
navic.setup({
	icons = {
		File = lspkind.symbol_map["File"] .. " ",
		Module = lspkind.symbol_map["Module"] .. " ",
		Class = lspkind.symbol_map["Class"] .. " ",
		Method = lspkind.symbol_map["Method"] .. " ",
		Property = lspkind.symbol_map["Property"] .. " ",
		Field = lspkind.symbol_map["Field"] .. " ",
		Constructor = lspkind.symbol_map["Constructor"] .. " ",
		Enum = lspkind.symbol_map["Enum"] .. " ",
		Interface = lspkind.symbol_map["Interface"] .. " ",
		Function = lspkind.symbol_map["Function"] .. " ",
		Variable = lspkind.symbol_map["Variable"] .. " ",
		Constant = lspkind.symbol_map["Constant"] .. " ",
		EnumMember = lspkind.symbol_map["EnumMember"] .. " ",
		Struct = lspkind.symbol_map["Struct"] .. " ",
		Event = lspkind.symbol_map["Event"] .. " ",
		Operator = lspkind.symbol_map["Operator"] .. " ",
	},
	lsp = {
		auto_attach = true,
	},
})
