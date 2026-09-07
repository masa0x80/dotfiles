-- NOTE: markdownlint の MD007 (ul-indent) のデフォルト値である2に揃える
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.opt_local.comments = { "nb:>" }
vim.opt_local.comments:append("nb:- [ ],nb:- [x],nb:- [-],nb:-")
vim.opt_local.comments:append("nb:+ [ ],nb:+ [x],nb:+ [-],nb:+")
vim.opt_local.comments:append("nb:* [ ],nb:* [x],nb:* [-],nb:*")
vim.opt_local.comments:append("nb:1. [ ],nb:1. [x],nb:1.")
vim.opt_local.comments:append("nb:1) [ ],nb:1) [x],nb:1)")
vim.opt_local.formatoptions = "tqjro"
