local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	conceallevel = 2, -- enable conceal
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	mousemoveevent = true, -- allow the mouse support
	pumheight = 10, -- pop up menu height
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- swapfile creation flag
	undofile = true, -- enable persistent undo
	updatetime = 2000, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	shiftround = true,
	softtabstop = 2,
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	cursorcolumn = true,
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	termguicolors = true,
	sidescrolloff = 3,
	laststatus = 3,
	completeopt = {
		"menu",
		"menuone",
		"noselect",
	},
	list = true,
	listchars = {
		tab = "┈┈",
		trail = "-",
		extends = "»",
		precedes = "«",
	},
	path = {
		".",
		"./plugins",
		"/usr/include",
		vim.fn.fnameescape(vim.fn.expand("$DOTFILE/.config/nvim/lua")),
		vim.fn.fnameescape(vim.fn.expand("$DOTFILE/.config/nvim/lua/config/plugins")),
		vim.fn.fnameescape(vim.fn.expand("$SCRAPBOOK_DIR")),
	},
	suffixesadd = { ".md", ".lua" },
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldcolumn = "1",
	foldlevel = 99,
	foldlevelstart = 99,
	fillchars = {
		foldopen = "▾",
		foldclose = "▸",
		foldsep = "┊",
		fold = "┊",
	},
	helplang = "ja,en",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("I")
vim.opt.whichwrap:append("b,s,h,l,<,>,[,],~")
vim.opt.iskeyword:append("-")

-- store tabpages and globals in session
vim.opt.sessionoptions:append("tabpages,globals")

-- disable netrw
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true
