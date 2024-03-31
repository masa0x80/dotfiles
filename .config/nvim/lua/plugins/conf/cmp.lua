vim.opt.runtimepath:append("~/.config/nvim/snippets")
require("luasnip/loaders/from_vscode").lazy_load()

local function has_copilot()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local icon = require("config.icon")
local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Text = icon.Text,
		Method = icon.Method,
		Function = icon.Function,
		Constructor = icon.Constructor,
		Field = icon.Field,
		Variable = icon.Variable,
		Class = icon.Class,
		Interface = icon.Interface,
		Module = icon.Module,
		Property = icon.Property,
		Unit = icon.Unit,
		Value = icon.Value,
		Enum = icon.Enum,
		Keyword = icon.Keyword,
		Snippet = icon.Snippet,
		Color = icon.Color,
		File = icon.Field,
		Reference = icon.Reference,
		Folder = icon.Folder,
		EnumMember = icon.EnumMember,
		Constant = icon.Constant,
		Struct = icon.Struct,
		Event = icon.Event,
		Operator = icon.Operator,
		TypeParameter = icon.TypeParameter,

		Copilot = icon.Copilot,
	},
})
require("copilot_cmp").setup()
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = function(_)
			if cmp.visible() then
				cmp.select_next_item()
			else
				local l, c = unpack(vim.api.nvim_win_get_cursor(0))
				vim.api.nvim_win_set_cursor(0, { l + 1, c })
			end
		end,
		["<C-p>"] = function(_)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				local l, c = unpack(vim.api.nvim_win_get_cursor(0))
				vim.api.nvim_win_set_cursor(0, { l - 1, c })
			end
		end,
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-x><C-c>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "c" }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(has_copilot() and { behavior = cmp.SelectBehavior.Select } or {})
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-x><C-x>"] = cmp.mapping(
			cmp.mapping.complete({
				config = {
					sources = {
						{ name = "spell" },
					},
				},
			}),
			{ "i", "c" }
		),
	}),
	window = {
		completion = {
			col_offset = -3,
			side_padding = 0,
		},
	},
	---@diagnostic disable-next-line: missing-fields
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			if strings[2] ~= "" then
				kind.menu = "    (" .. strings[2] .. ")"
			end

			return kind
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "copilot" },
		{ name = "path" },
	}, {
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
	}),
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

local c = require("config.color")
local set_hl = vim.api.nvim_set_hl

set_hl(0, "CmpItemAbbrDeprecated", { fg = c.green, bg = "NONE", strikethrough = true })
set_hl(0, "CmpItemAbbrMatch", { fg = c.blue, bg = "NONE", underline = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.blue, bg = "NONE", underline = true })
set_hl(0, "CmpItemMenu", { fg = c.purple, bg = "NONE", italic = true })

set_hl(0, "CmpItemKindField", { fg = c.fg, bg = c.dark_red })
set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

set_hl(0, "CmpItemKindText", { fg = c.black, bg = c.green })
set_hl(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
set_hl(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

set_hl(0, "CmpItemKindConstant", { fg = c.black, bg = c.yellow })
set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

set_hl(0, "CmpItemKindFunction", { fg = c.black, bg = c.purple })
set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

set_hl(0, "CmpItemKindVariable", { fg = c.fg, bg = c.grey })
set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

set_hl(0, "CmpItemKindUnit", { fg = c.black, bg = c.dark_yellow })
set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
set_hl(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

set_hl(0, "CmpItemKindMethod", { fg = c.black, bg = c.blue })
set_hl(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

set_hl(0, "CmpItemKindInterface", { fg = c.black, bg = c.cyan })
set_hl(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindInterface" })
