-- runtimepath: don't load system configuration, as it can introduce configuration conflicts and unwanted bindings
vim.opt.runtimepath = ''
 .. vim.fn.stdpath('config') .. ','
 .. vim.fn.stdpath('data') .. '/site,'
 .. vim.fn.expand('$VIMRUNTIME') .. ','
 .. '/usr/lib/nvim,'
 .. vim.fn.stdpath('data') .. '/site/after,'
 .. vim.fn.stdpath('config') .. '/after'

-- for reference, below is a recreation of the default runtimepath
-- vim.opt.runtimepath = ''
--  .. vim.fn.stdpath('config') .. ','
--  .. table.concat(vim.fn.stdpath('config_dirs'), ',') .. ','
--
--  .. vim.fn.stdpath('data') .. '/site,'
--  .. table.concat(vim.fn.stdpath('data_dirs'), '/site,') .. '/site,'
--
--  .. vim.fn.expand('$VIMRUNTIME') .. ','
--  .. '/usr/lib/nvim,'
--
--  .. table.concat(vim.fn.stdpath('data_dirs'), '/site/after,') .. '/site/after,'
--  .. vim.fn.stdpath('data') .. '/site/after,'
--
--  .. table.concat(vim.fn.stdpath('config_dirs'), '/after,') .. '/after,'
--  .. vim.fn.stdpath('config') .. '/after,'
--  .. '/usr/share/vim/vimfiles,'
--  .. '/usr/share/vim/vimfiles/after'

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

-- Use system installs for plugin hosts
vim.g.loaded_node_provider = nil
vim.g.node_host_prog = '/usr/bin/neovim-node-host'

vim.g.loaded_python3_provider = nil
vim.g.python3_host_prog = '/bin/python'


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
-- nvim.undotree is much worse than mbbill/undotree
-- vim.cmd.packadd{'nvim.undotree', bang = true}

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == 'nvim-treesitter' and kind == 'update' then
		if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
		vim.cmd('TSUpdate')
	end
	if name == 'markdown-preview' and (kind == 'install' or kind == 'update') then
		os.execute('cd "' .. ev.data.path .. '" && npm install')
	end
end })

vim.pack.add({
	-- core
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/kshenoy/vim-signature',
	'https://github.com/mhinz/vim-grepper',
	'https://github.com/mbbill/undotree',

	-- treesitter
	'https://github.com/nvim-treesitter/nvim-treesitter',

	-- lsp
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',

	-- completion
	'https://github.com/hrsh7th/cmp-buffer',
	'https://github.com/hrsh7th/cmp-cmdline',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
	'https://github.com/hrsh7th/cmp-path',
	'https://github.com/hrsh7th/nvim-cmp',

	-- file manager
	'https://github.com/stevearc/oil.nvim',

	-- outline
	'https://github.com/stevearc/aerial.nvim',

	-- git
	'https://github.com/tpope/vim-fugitive',

	-- markdown
	'https://github.com/nelstrom/vim-markdown-folding',
	'https://github.com/iamcco/markdown-preview.nvim',

	-- visual
	'https://github.com/elliothatch/burgundy.vim',
	'https://github.com/chrisbra/Colorizer',
	-- 'https://github.com/dstein64/nvim-scrollview',
	'https://github.com/nvim-treesitter/nvim-treesitter-context',

	-- misc
	'https://codeberg.org/andyg/leap.nvim',
	'https://github.com/max397574/colortils.nvim',

	-- 'https://github.com/vim-scripts/headerguard',

	-- dap
	-- 'https://github.com/mfussenegger/nvim-dap',
	-- 'https://github.com/rcarriga/nvim-dap-ui',
	-- 'https://github.com/nvim-neotest/nvim-nio',
})

-- TODO:
-- dap

vim.cmd('colorscheme burgundy')
