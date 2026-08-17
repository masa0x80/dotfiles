vim.opt_local.commentstring = "' %s"

local ok, comment_ft = pcall(require, "Comment.ft")
if ok then
	comment_ft.set("plantuml", { "'%s", "'%s" })
end

vim.keymap.set(
	"n",
	"<C-_><C-b>",
	"<Plug>(comment_toggle_linewise_current)",
	{ buffer = true, desc = "Toggle line-comment" }
)
vim.keymap.set(
	"x",
	"<C-/><C-b>",
	"<Plug>(comment_toggle_linewise_visual)",
	{ buffer = true, desc = "Toggle line-comment" }
)
