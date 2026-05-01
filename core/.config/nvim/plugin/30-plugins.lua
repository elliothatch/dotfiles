-- mhinz/vim-grepper
vim.g.grepper = {
	tools = {'rg', 'git'},
	rg = {
		grepprg = 'rg --vimgrep --hidden',
		grepformat = '%f:%l:%c:%m',
	}
}

-- stevearc/oil.nvim
require('oil').setup({
	view_options = {
		show_hidden = true,
	}
})

-- stevearc/aerial.nvim
require('aerial').setup({
	filter_kind = {
		'Class',
		'Constructor',
		'Enum',
		'Function',
		'Interface',
		'Method',
		'Module',
		'Namespace',
		'Struct',
	},

	-- default behavior is fine actually...
	-- many symbols not appearing in outline for treesitter
	-- this is actually pretty nice for some languages as it cuts down on clutter (e.g. typescript closures are displayed on LSP but not treesitter)
	-- use LSP backend for problematic languages
	-- backends = {
	-- 	['_'] = {"treesitter", "lsp", "markdown", "asciidoc", "man"},
	-- 	json = {"lsp", "markdown", "asciidoc", "man", "treesitter"},
	-- 	jsonc = {"lsp", "markdown", "asciidoc", "man", "treesitter"},
	-- },
	-- filter_kind = {
	-- 	['_'] = {
	-- 		'Class',
	-- 		'Constructor',
	-- 		'Enum',
	-- 		'Function',
	-- 		'Interface',
	-- 		'Method',
	-- 		'Module',
	-- 		'Namespace',
	-- 		'Struct',
	-- 	},
	-- 	json = false,
	-- 	jsonc = false,
	-- },
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
		vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
		vim.keymap.set('n', 'gO', '<cmd>AerialToggle<CR>', { buffer = bufnr })
	end,
})

-- nvim-treesitter/nvim-treesitter-context
require('treesitter-context').setup{
	min_window_height = 30,
}

vim.cmd('highlight TreesitterContext guifg=NONE guibg=#4d152b guisp=#4d152b gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE')
vim.cmd('highlight TreesitterContextLineNumber guifg=#f7f7f7 guibg=#611835 guisp=#611835 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE')

require('leap').opts.safe_labels = ''
-- Skip preview for matches starting with whitespace or an
-- alphabetic mid-word character: foobar[baaz] = quux
--                                *    ***  ** * *  *
require('leap').opts.preview = function(ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end
