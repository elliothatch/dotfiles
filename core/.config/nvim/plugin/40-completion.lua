vim.opt.completeopt = 'menuone,noselect,preview'
-- try fuzzy, popup

-- hrsh7th/nvim-cmp (auto completion)
local cmp = require('cmp')
cmp.setup({
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.abort(),
		-- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources(
		{{ name = 'nvim_lsp' }},
		{{ name = 'nvim_lsp_signature_help' }},
		{{ name = 'buffer' }},
		{{ name = 'path' }}
	),
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				buffer = '[B]',
				nvim_lsp = '[L]',
				path = '[P]',
			})[entry.source.name]
			return vim_item
		end
	}
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		--{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
