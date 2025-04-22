local lspkind = require("lspkind")
local navic = require("nvim-navic")
navic.setup({
	icons = {
		File = lspkind.symbolic("File") .. " ",
		Module = lspkind.symbolic("Module") .. " ",
		Class = lspkind.symbolic("Class") .. " ",
		Method = lspkind.symbolic("Method") .. " ",
		Property = lspkind.symbolic("Property") .. " ",
		Field = lspkind.symbolic("Field") .. " ",
		Constructor = lspkind.symbolic("Constructor") .. " ",
		Enum = lspkind.symbolic("Enum") .. " ",
		Interface = lspkind.symbolic("Interface") .. " ",
		Function = lspkind.symbolic("Function") .. " ",
		Variable = lspkind.symbolic("Variable") .. " ",
		Constant = lspkind.symbolic("Constant") .. " ",
		EnumMember = lspkind.symbolic("EnumMember") .. " ",
		Struct = lspkind.symbolic("Struct") .. " ",
		Event = lspkind.symbolic("Event") .. " ",
		Operator = lspkind.symbolic("Operator") .. " ",
	},
	lsp = {
		auto_attach = true,
	},
})
