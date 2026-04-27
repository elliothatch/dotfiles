require('nvim-treesitter').install('all')

local augroupTreesitter = vim.api.nvim_create_augroup('config.Treesitter', {})
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if vim.treesitter.language.add(lang) then
			vim.treesitter.start()
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
	group = augroupTreesitter,
})

-- lower priority of semantic tokens, since they often override treesitter and break highlighting
vim.highlight.priorities.semantic_tokens = 95

