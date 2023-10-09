local ft = require("guard.filetype")

ft("dockerfile"):lint("hadolint")

require("guard").setup({
	fmt_on_save = false,
	lsp_as_default_formatter = false,
})
