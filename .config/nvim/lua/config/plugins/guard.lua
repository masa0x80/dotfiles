local ft = require("guard.filetype")

ft("dockerfile"):lint("hadolint")

ft("go"):fmt({
	cmd = "goimports",
	args = { "-w" },
	fname = true,
}):append({
	cmd = "cat",
	fname = true,
})

ft("javascript,javascriptreact,typescript,typescriptreact,vue,css,scss,less,html,json,jsonc,yaml,graphql,handlebars"):fmt(
	"prettier"
)

ft("lua,luau"):fmt("stylua")

ft("markdown")
	:fmt({
		cmd = "textlint",
		args = { "--fix", "--quiet" },
		fname = true,
	})
	:append({
		cmd = "markdownlint",
		args = { "--fix", "--quiet" },
		fname = true,
	})
	:append({
		cmd = "cat",
		fname = true,
	})

ft("python"):fmt("black")

ft("sh"):fmt({
	cmd = "shfmt",
	args = { "-filename" },
	fname = true,
})

ft("txt"):fmt({
	cmd = "textlint",
	args = { "--fix", "--quiet" },
	fname = true,
}):append({
	cmd = "cat",
	fname = true,
})

require("guard").setup({
	fmt_on_save = true,
	lsp_as_default_formatter = false,
})
