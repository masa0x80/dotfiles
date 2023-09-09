vim.opt.runtimepath:append("~/.config/nvim/snippets")
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Class = "",
		Constructor = "",
		Interface = "",
		Text = " ",
		TypeParameter = "",
	},
})
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
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
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
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
	-- sources = {
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
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

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl

set_hl(0, "CmpItemAbbrDeprecated", { fg = color.Green, bg = "NONE", strikethrough = true })
set_hl(0, "CmpItemAbbrMatch", { fg = color.Blue, bg = "NONE", bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = color.Blue, bg = "NONE", bold = true })
set_hl(0, "CmpItemMenu", { fg = color.Magenta, bg = "NONE", italic = true })

set_hl(0, "CmpItemKindField", { fg = color.White, bg = color.DarkRed })
set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

set_hl(0, "CmpItemKindText", { fg = color.Black, bg = color.Green })
set_hl(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
set_hl(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

set_hl(0, "CmpItemKindConstant", { fg = color.Black, bg = color.Yellow })
set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

set_hl(0, "CmpItemKindFunction", { fg = color.Black, bg = color.Magenta })
set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

set_hl(0, "CmpItemKindVariable", { fg = color.White, bg = color.GutterGrey })
set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

set_hl(0, "CmpItemKindUnit", { fg = color.Black, bg = color.DarkYellow })
set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
set_hl(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

set_hl(0, "CmpItemKindMethod", { fg = color.Black, bg = color.Blue })
set_hl(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

set_hl(0, "CmpItemKindInterface", { fg = color.Black, bg = color.Cyan })
set_hl(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
