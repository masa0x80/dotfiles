local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = false, -- set relative numbered lines
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
		tab = "» ",
		trail = "-",
		extends = "»",
		precedes = "«",
		nbsp = "%",
	},
	path = {
		".",
		"/usr/include",
		vim.fn.fnameescape(vim.fn.expand("$DOTFILE/.config/nvim/lua")),
		vim.fn.fnameescape(vim.fn.expand("$DOTFILE/.config/nvim/lua/config/plugins")),
		vim.fn.fnameescape(vim.fn.expand("$SCRAPBOOK_DIR")),
	},
	suffixesadd = { ".md", ".lua" },
	spelllang = { "en_us", "cjk" },
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- store tabpages and globals in session
vim.opt.sessionoptions:append("tabpages,globals")

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.includeexpr = "substitute(v:fname, '\\.', '/', 'g')"
