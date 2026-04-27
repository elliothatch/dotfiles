-- the text kind of just looks nicer
-- local diagnosticSymbols = {
-- 	[vim.diagnostic.severity.ERROR] = '✖',
-- 	[vim.diagnostic.severity.WARN] = '❗',
-- 	[vim.diagnostic.severity.INFO] = '🛈',
-- 	[vim.diagnostic.severity.HINT] = '❓',
-- }

vim.diagnostic.config({
	severity_sort = true,
	signs = {
		-- letters looks nicer
		-- text = diagnosticSymbols
	},
	-- doesn't work for some reason?
	-- status = diagnosticSymbols,
})

require('mason').setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		-- lsp
		-- 'angularls',         -- Angular
		-- 'asm_lsp',           -- Assembly (GAS/NASM, GO)
		'bashls',            -- Bash
		'clangd',            -- C/C++
		-- 'clojure_lsp',       -- Clojure
		-- 'cmake',             -- CMake
		'csharp_ls',         -- C#
		'cssls',             -- CSS
		'docker_language_server', -- Docker
		'eslint',            -- ESLint
		'fish_lsp',          -- Fish
		'gh_actions_ls',     -- GitHub Actions
		'gopls',             -- Go
		-- 'graphql',           -- GraphQL
		-- 'hls',               -- Haskell
		'html',              -- HTML
		-- 'jdtls',             -- Java
		'jqls',              -- jq
		-- 'jsonld-lsp',        -- JSON-LD
		'jsonls',            -- JSON
		'lemminx',           -- XML
		'lua_ls',            -- Lua
		-- 'openscad_lsp',      -- OpenSCAD
		'perlnavigator',     -- Perl
		'phpactor',          -- PHP
		-- 'powershell_es'      -- Powershell
		'postgres_lsp',      -- Postgres
		'pyright',             -- Python (docs)
		-- 'r_language_server', -- R
		-- 'solargraph',        -- Ruby
		'rust_analyzer',     -- Rust
		'sqlls',              -- SQL
		'taplo',             -- TOML
		'texlab',            -- LaTeX
		'ts_ls',             -- TypeScript
		'vimls',             -- VimL
		-- 'wgsl_analyzer',     -- WGSL
		'yamlls',            -- YAML
		'zk',                -- Markdown


		-- dap
		-- 'codelldb',
		-- 'cpptools',
		-- 'debugpy',
		-- 'go-debug-adapter',
		-- 'java-debug-adapter',
		-- 'java-test',
		-- 'js-debug-adapter',
		-- 'netcoredbg',
		-- 'node-debug2-adapter',
	}
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	}
})

local augroupLsp = vim.api.nvim_create_augroup('config.Lsp', {})

vim.api.nvim_create_autocmd('LspAttach', {
	group = augroupLsp,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		--Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- local bufopts = { noremap=true, silent=true, buffer=args.buf }
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		-- vim.keymap.set('n', '<leader>td', vim.lsp.buf.definition, bufopts)
		-- vim.keymap.set('n', '<leader>tm', vim.lsp.buf.hover, bufopts)
		-- vim.keymap.set('n', '<leader>ti', vim.lsp.buf.implementation, bufopts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		-- vim.keymap.set('n', '<space>wl', function()
		-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, bufopts)
		-- vim.keymap.set('n', '<leader>tD', vim.lsp.buf.type_definition, bufopts)
		-- vim.keymap.set('n', '<leader>tR', vim.lsp.buf.rename, bufopts)
		-- vim.keymap.set('n', '<leader>ta', vim.lsp.buf.code_action, bufopts)
		-- vim.keymap.set('n', '<leader>tr', vim.lsp.buf.references, bufopts)
		-- vim.keymap.set('n', '<leader>t=', function() vim.lsp.buf.format { async = true } end, bufopts)

		if client:supports_method('textDocument/documentHighlight') then
			-- highlight symbol under cursor
			vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
				group = augroupLsp,
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.document_highlight()
				end,
			})
			vim.api.nvim_create_autocmd({'CursorMoved'}, {
				group = augroupLsp,
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end
	end,
})
