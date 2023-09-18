local ft = require("guard.filetype")
local lint = require("guard.lint")

ft("dockerfile"):lint("hadolint")

ft("javascript,javascriptreact,typescript,typescriptreact,vue,css,scss,less,html,json,jsonc,yaml,graphql,handlebars"):fmt(
	"prettier"
)

ft("lua,luau"):fmt("stylua")

ft("markdown"):fmt({
	cmd = "markdownlint-fix-wrap",
	fname = true,
})

ft("python"):fmt("black")

ft("sh,zsh"):fmt({
	cmd = "shfmt",
	args = { "-filename" },
	fname = true,
}):lint("shellcheck")

ft("terraform,tf,terraform-vars"):fmt({
	cmd = "terraform-fmt-wrap",
	fname = true,
})

ft("txt"):fmt({
	cmd = "textlint-fix-wrap",
	fname = true,
})

require("guard").setup({
	fmt_on_save = true,
	lsp_as_default_formatter = false,
})
