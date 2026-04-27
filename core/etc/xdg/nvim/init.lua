-- Editor settings
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.softtabstop = -1
vim.opt.copyindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.undofile = true
vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.title = true

vim.opt.foldlevelstart = 2

vim.opt.grepprg = 'rg --vimgrep --hidden'
vim.opt.updatetime = 500

-- Visual settings
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.list = true
vim.opt.listchars = {
	tab = '▸-',
	trail = '.',
	extends = '❯',
	precedes = '❮',
}
vim.opt.showbreak = '↪'
vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.colorcolumn = '81'
-- vim.opt.lazyredraw = true
-- vim.opt.termguicolors = true

-- disable providers for safety and speed
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local augroupHighlight = vim.api.nvim_create_augroup('config.YankHighlight', {})
vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ timeout = 800})
	end,
	group = augroupHighlight,
})

-- Plugins
vim.cmd.packadd{'nvim.difftool', bang = true}
vim.cmd.packadd{'cfilter', bang = true}
vim.cmd.packadd{'justify', bang = true}
-- vim.cmd.packadd{'nohlsearch', bang = true}
vim.cmd.packadd{'termdebug', bang = true}
vim.cmd.packadd{'nvim.tohtml', bang = true}
vim.cmd.packadd{'nvim.undotree', bang = true}

vim.cmd('colorscheme burgundy')
