local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local languages = {
	"bash",
	"css",
	"dockerfile",
	"go",
	"graphql",
	"javascript",
	"jsdoc",
	"json",
	"html",
	"lua",
	"make",
	"python",
	"ruby",
	"rust",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"yaml",
}

treesitter.setup({
	ensure_installed = languages,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			scope_incremental = "<C-i>",
			node_decremental = "V",
		},
	},
})
