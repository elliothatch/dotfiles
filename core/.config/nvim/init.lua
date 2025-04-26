-- this might cause problems but it silences the undefined global warnings on each line
local vim = vim

-- Editor settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = -4
vim.opt.copyindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.title = true

vim.opt.completeopt = 'menuone,noselect,preview'
vim.opt.foldlevelstart = 2

vim.opt.grepprg = 'ack -k'

vim.opt.updatetime = 300

vim.g.python3_host_prog = '/bin/python'
-- using the global python install is fine
-- vim.g.python3_host_prog = '/home/ellioth/.local/python-venv/neovim/bin/python'


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
vim.opt.lazyredraw = true
vim.opt.termguicolors = true

-- autocmds

vim.cmd([[
function! RemoveBufferIfPreview()
    if &previewwindow
        set nobuflisted
    endif
endf
augroup myautocmds
	autocmd!
	" automatically add the current extension to 'gf' paths
	autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
	" make  '-' part of words in css files
	autocmd FileType css,sass,scss execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted
	" use spaces instead of tabs in certain filetypes
	autocmd FileType typescript execute 'setl expandtab'
	" don't add preview window buffers to buffer list
	autocmd BufEnter * call RemoveBufferIfPreview()

	" WHY DOESN'T dapui* work???
	autocmd FileType dapui* setl statusline=[%n]%f
	autocmd FileType dap-repl setl statusline=[%n]%f

	" outline uses comment highlight group for vertical pipes, turn off italics
	" autocmd FileType Outline execute 'hi Comment gui=NONE cterm=NONE'
	"  autocmd FileType Outline execute 'hi Folded guifg=#f2ead7 guibg=#1a0a16 guisp=#1a0a16 gui=NONE ctermfg=230 ctermbg=234 cterm=NONE'
	" autocmd FileType Outline execute 'setl foldlevel=1|setl foldexpr=FoldOutline(v:lnum)|setl foldmethod=expr'
augroup END

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker keywordprg=:help
    au FileType help setlocal textwidth=78
	au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
]])

-- Plugins
vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'mbbill/undotree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-commentary'
Plug 'ggandor/lightspeed.nvim'

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/nvim-cmp'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" git
Plug 'tpope/vim-fugitive'

" grep
Plug 'mileszs/ack.vim'

" folding
Plug 'nelstrom/vim-markdown-folding'

" visual
Plug 'elliothatch/burgundy.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'dstein64/nvim-scrollview'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'chrisbra/Colorizer'

" syntax
" Plug 'sheerun/vim-polyglot'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'mustache/vim-mustache-handlebars'

" tags
Plug 'simrat39/symbols-outline.nvim'

" debug
Plug 'nvim-neotest/nvim-nio'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" c
Plug 'vim-scripts/headerguard'

call plug#end()
]])

--  ggandor/lightspeed.nvim
require'lightspeed'.setup {
	ignore_case = true
}

vim.cmd([[
	" disable ft repeat (DOESN'T WORK')
    " augroup lightspeed_active
    " autocmd!
	" autocmd User LightspeedFtEnter normal <ESC>
    " augroup end
    " just unbind ft instead
    noremap f f
    noremap F F
    noremap t t
    noremap T T
    noremap ; ;
    noremap , ,
]])


-- hrsh7th/nvim-cmp (auto completion)
local cmp = require'cmp'
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
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
--[[
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
]]--

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- NOTE: extra slashes on path completion: https://github.com/hrsh7th/cmp-cmdline/issues/60
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		--{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP
require('mason').setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		-- lsp
		'bashls',            -- Bash
		'clangd',            -- C
		'csharp_ls',         -- C#
		'clangd',            -- C++
		'cmake',             -- CMake
		'cssls',             -- CSS
		'dockerls',          -- Docker
		'eslint',            -- ESLint
		'gopls',             -- Go
		'html',              -- HTML
		'jsonls',            -- JSON
		'jdtls',             -- Java
		'texlab',            -- LaTeX
		'lua_ls',       -- Lua
		'zk',                -- Markdown
		-- 'openscad_lsp',      -- OpenSCAD
		-- 'phpactor',          -- PHP
		'perlnavigator',     -- Perl
		-- 'powershell_es',     -- Powershell
		'pyright',             -- Python (docs)
		-- 'r_language_server', -- R
		-- 'solargraph',        -- Ruby
		'rust_analyzer',     -- Rust
		'sqlls',              -- SQL
		'taplo',             -- TOML
		'tsserver',          -- TypeScript
		'vimls',             -- VimL
		'lemminx',           -- XML
		'yamlls',            -- YAML

		-- 'angularls',         -- Angular
		-- 'asm_lsp',           -- Assembly (GAS/NASM, GO)
		-- 'clojure_lsp',       -- Clojure
		-- 'hls',               -- Haskell
		-- 'wgsl_analyzer',     -- WGSL

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

local lsp_on_attach = function(client, bufnr)
	--Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<leader>td', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<leader>tm', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>ti', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set('n', '<leader>tD', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>tR', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ta', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<leader>tr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>t=', function() vim.lsp.buf.format { async = true } end, bufopts)

	if client.supports_method('textDocument/documentHighlight') then
		-- highlight symbol under cursor
		vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
		vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
		vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

	end
	require('lsp-status').on_attach(client, bufnr)
end

require('mason-lspconfig').setup_handlers {
	-- default handler
	function (server_name) -- default handler (optional)
		require('lspconfig')[server_name].setup {
			on_attach = lsp_on_attach,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			}
		}
	end,
	-- dedicated handlers
	['pylsp'] = function ()
		require('lspconfig')['pylsp'].setup {
			on_attach = lsp_on_attach,
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						mccabe = {
							enabled = false
						},
						pycodestyle = {
							ignore = {
								"E501", -- line exceeds max line length
								"E226", -- missing whitespace around arithmetic operator
								"E241", -- multiple spaces after ':'
								"W503", -- line break before binary operator. this will soon be considered best practice
								"E741", -- ambiguous variable name
							}
						}
					}
				}
			}
		}
	end
}

vim.fn.sign_define("LspDiagnosticsSignError", {text = "✖"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "❗"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "🛈"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "❓"})

-- require('vim.lsp.protocol').CompletionItemKind = {
--     '', -- Text
--     '', -- Method
--     '', -- Function
--     '', -- Constructor
--     '', -- Field
--     '', -- Variable
--     '', -- Class
--     'ﰮ', -- Interface
--     '', -- Module
--     '', -- Property
--     '', -- Unit
--     '', -- Value
--     '了', -- Enum
--     '', -- Keyword
--     '﬌', -- Snippet
--     '', -- Color
--     '', -- File
--     '', -- Reference
--     '', -- Folder
--     '', -- EnumMember
--     '', -- Constant
--     '', -- Struct
--     '', -- Event
--     'ﬦ', -- Operator
--     '', -- TypeParameter
-- }

-- require('vim.lsp.protocol').CompletionItemKind[2] = 'λ' -- Method
-- require('vim.lsp.protocol').CompletionItemKind[3] = 'λ' -- Function
-- require('vim.lsp.protocol').CompletionItemKind[4] = 'λ' -- Constructor

-- nvim-lua/lsp-status.nvim
local indicator_ok = '✔'
local component_separator = ' | '

require('lsp-status').config({
	kind_labels = vim.g.completion_customize_lsp_label,
	status_symbol = '',
	indicator_errors = '✖ ',
	indicator_warnings = '❗',
	indicator_info = '🛈 ',
	indicator_hint = '❓',
	indicator_ok = indicator_ok,
	indicator_separator = '',
	component_separator = component_separator,
	-- disable everything except current_function, we build the diagnostics pane separately so it can be positioned separately in the statusline
	diagnostics = false,
})

require('lsp-status').register_progress()

function _G.lsp_current_function()
	local current_function = vim.b.lsp_current_function
	if #vim.lsp.buf_get_clients() > 0 and current_function and current_function ~= '' then
		return '(' .. current_function .. ')'
	end

	return ''
end

function _G.lsp_status_diagnostics()
	if #vim.lsp.buf_get_clients() <= 0 then
		return ''
	end

	local errors = require('lsp-status').status_errors()
	local warnings = require('lsp-status').status_warnings()
	local info = require('lsp-status').status_info()
	local hints = require('lsp-status').status_hints()
	local progress = require('lsp-status').status_progress()

	local status_parts = {}

	if errors then
		table.insert(status_parts, errors)
	end
	if warnings then
		table.insert(status_parts, warnings)
	end
	if info then
		table.insert(status_parts, info)
	end
	if hints then
		table.insert(status_parts, hints)
	end
	local base_status = vim.trim(table.concat(status_parts, component_separator) .. ' ' .. progress)

	if base_status ~= '' then return ' ' .. base_status .. ' ' end
	return ' ' .. indicator_ok .. ' '
end

-- simrat39/symbols-outline.nvim
require('symbols-outline').setup({
	auto_preview = true;
	autofold_depth = 2;
	fold_markers = { "▸", "▾" };
	symbols = {
		Component = { icon = "C" },
		Constant = { icon = "C" },
		Constructor = { icon = "C" },
		File = { icon = "🗎" },
		Fragment = { icon = "F" },
		Interface = { icon = "I" },
		Module = { icon = 'M' },
		Variable = { icon = "V" },
	}
})

-- Treesitter
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		-- additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
	},
	-- custom_captures = {
	-- remove the "constructor" highlight capture because nvim-treesitter annoyingly assumes any identifier starting with a capital letter is a constructor
	-- this doesn't seem to work, so I removed the @constructor and @constant queries by invoking :TSEditQuery highlights and commenting out the relevant lines from ECMA
	-- this hopefully won't be necessary after this issue is merged https://github.com/nvim-treesitter/nvim-treesitter/pull/1556
	--['constructor'] = nil
	-- },
	ensure_installed = 'all',
	--{
	-- 'bash',
	-- 'c',
	-- 'c_sharp',
	-- 'clojure',
	-- 'cmake',
	-- 'cpp',
	-- 'css',
	-- 'dockerfile',
	-- 'gdscript'
	-- 'go',
	-- 'gomod',
	-- 'haskell',
	-- 'html',
	-- 'java',
	-- 'javascript',
	-- 'jsdoc',
	-- 'json',
	-- 'jsonc',
	-- 'latex',
	-- 'lua',
	-- 'php',
	-- 'python',
	-- 'r',
	-- 'regex',
	-- 'ruby',
	-- 'rust',
	-- 'scss',
	-- 'tsx',
	-- 'typescript',
	-- 'yaml',

	-- 'comment',
	-- 'commonlisp',
	-- 'elixir',
	-- 'graphql',
	-- 'ocaml',
	-- 'Tree-sitter query language',
	-- 'swift'
	--}
	playground = {
		enable = true,
	}
}

vim.treesitter.language.register('glimmer', 'handlebars')

-- nvim-dap
local dap = require('dap')

--[[
--for some reason the adapter doesn't launch when using mason installed DAP
if require('mason-registry').has_package('debugpy') then
	dap.adapters.python = {
		type = 'executable';
		command = require('mason-registry').get_package('debugpy'):get_install_path() .. '/debugpy'
	}
else
	dap.adapters.python = {
		type = 'executable';
		command = 'python';
		args = { '-m', 'debugpy.adapter' };
	}
end
]]--

dap.adapters.python = {
	type = 'executable';
	command = 'python';
	args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch';
		name = "Launch file";
		console = 'integratedTerminal';

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}"; -- This configuration will launch the current file if used.
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end;
	},
	{
		type = 'python';
		request = 'launch';
		name = "Run tests";
		console = 'integratedTerminal';

		module = "unittest";
	},
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {'/usr/lib/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- " nvim-dap-ui
local dapui = require("dapui")
dapui.setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "▸"
	},
	controls = {
		icons = {
			pause = "⏸",
			play = "⏵",
			step_into = "↓",
			step_over = "↷",
			step_out = "↑",
			step_back = "⇤",
			run_last = "⟲",
			terminate = "⏹",
		},
	},
	layouts = { {
		elements = { {
			id = "breakpoints",
			size = 0.2
			}, {
				id = "stacks",
				size = 0.2
			}, {
				id = "watches",
				size = 0.1
			}, {
				id = "scopes",
				size = 0.5
		} },
		position = "left",
		size = 40
		}, {
			elements = { {
				id = "repl",
				size = 0.5
				}, {
					id = "console",
					size = 0.5
			} },
			position = "bottom",
			size = 10
		}, {
			elements = { {
				id = "console",
				size = 1.0
			} },
			position = "bottom",
			size = 10
		}
	},
})

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
--
-- on launch, open the console
dap.listeners.after['launch']['on_launch'] = function()
	dapui.open(3)
end

-- on stop (e.g. hit breakpoint) open the debug panes
dap.listeners.after['event_stopped']['on_stop'] = function()
	dapui.close(3)
	dapui.open(1)
	dapui.open(2)
end

-- on process exit close the debug panes, but open the console to view debugee output
dap.listeners.after['event_exited']['on_exit'] = function()
	dapui.close(1)
	dapui.close(2)
	dapui.open(3)
end

-- Bindings
vim.cmd([[

map <space> <leader>
map <space><space> <leader><leader>

nnoremap <leader>w :w<cr>
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>n :enew<cr>
" close buffer without closing the window
" switch to alternate buffer and close the buffer we were just on
" if the alternate buffer is unlisted, go to the previous buffer instead
" if we are closing the last listed buffer, create a new blank buffer to switch to
nnoremap <expr> <leader>q len(getbufinfo({'buflisted':1})) == 1 ? ':enew<cr>:bd#<cr>' : (buflisted(bufnr('#')) ? ':b #<cr>:bd #<cr>' : ':bp<cr>:bd #<cr>')

" visual cursor movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easier to type
noremap H ^
noremap L $
vnoremap L g_
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to something similar: move to last change
nnoremap gI `.

" Windows
nnoremap <leader>Q :close<cr>
noremap <leader>v <C-w>v<C-w>l
noremap <leader>V <C-w>S<C-w>j

" ctrl-movement keys for window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>

" visual mode
vnoremap > >gv
vnoremap < <gv

" file browser
nnoremap <leader>e :E<cr>
nnoremap <expr> <leader>E ':E ' . getcwd() . '<cr>'

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

vnoremap <leader>s :sort<CR>

" select contents of current line, excluding indentation
nnoremap vv ^vg_

" diff current window
" nnoremap <leader>d :diffthis<cr>

" folding
"  Fold comments
noremap <silent> <leader>zc :set foldmethod=expr<cr>:set foldexpr=synIDattr(synID(v:lnum,strlen(getline(v:lnum)),1),'name')=~?'comment'?'1':getline(v:lnum)=~'^\\s*$'?'=':'0'<cr>zM<cr>
" focus the current line (close all folds except this one, then center the screen)
nnoremap <leader>z zMzvzz

" Quickfix List
nnoremap <leader>co :botright copen<cr>
nnoremap <leader>cc :cclose<cr>

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>

" location list
nnoremap <leader>Co :lopen<cr>
nnoremap <leader>Cc :lclose<cr>

nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]L :llast<cr>
nnoremap [L :lfirst<cr>

" preview window
nnoremap <leader>m <C-w>}
nnoremap <leader>pc :pclose!<cr>

" format json
nnoremap <leader>fj :%! python -m json.tool<CR>
vnoremap <leader>fj :! python -m json.tool<CR>

" convert (format) to hex
nnoremap <expr> <leader>fh :%!od -A x -t x1z -v<CR>

" terminal mode
" map ctrl-movement keys to switch windows (can be used to exit terminal mode quickly)
tnoremap <C-k> <C-\><C-N><C-w><Up>
tnoremap <C-j> <C-\><C-N><C-w><Down>
tnoremap <C-l> <C-\><C-N><C-w><Right>
tnoremap <C-h> <C-\><C-N><C-w><Left>

" Plugin bindings
" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" junegunn/fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-Space> :Buffers<CR>

" tpope/vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gU :Gread<CR>
nnoremap <leader>gc :Gcommit<CR>

" nvim-dap
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dl <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dd <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dc <Cmd>lua require'dap'.run_to_cursor()<CR>

" mileszs/ack.vim
function! InputOrCancel(prefix, prompt, suffix)
	call inputsave()
	let l:result = input(a:prompt)
	if l:result == ''
		return '<cr>'
	endif
	call inputrestore()
	let l:cmd = a:prefix . l:result . a:suffix
	call histadd('cmd', l:cmd)
	return ':' . l:cmd
endfunc

"nnoremap <expr> <leader>ss ':Ack! '          . input('[ack]: ')              . ' ' . expand('%:p:h') . '<cr>'
nnoremap <expr> <leader>ss InputOrCancel('Ack! ',    '[ack]: ',     '') . '<cr>'
nnoremap <expr> <leader>sl InputOrCancel('LAck ',    '[ack]\|L: '), '') . '<cr>'
nnoremap <expr> <leader>sf InputOrCancel('AckFile ', '[ack]\|F: '), '') . '<cr>'
nnoremap <expr> <leader>s/ ':AckFromSearch ' . '<cr>'

" search from current buffer path
nnoremap <expr> <leader>Ss InputOrCancel('Ack! ',    '[ack\|b]: ',    ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>Sl InputOrCancel('LAck ',    '[ack\|b]\|L: ', ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>Sf InputOrCancel('AckFile ', '[ack\|b]\|F: ', ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>S/ ':AckFromSearch ' . expand('%:p:h') . '<cr>'

" puts quickfix files in args
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let l:buffer_numbers = {}
  for l:quickfix_item in getqflist()
    let l:buffer_numbers[l:quickfix_item['bufnr'] ] = bufname(l:quickfix_item['bufnr'])
  endfor
  return join(map(values(l:buffer_numbers), 'fnameescape(v:val)'))
endfunction

" run command on each file in quickfix
" to save changes, run :argdo update
nnoremap <expr> <leader>r InputOrCancel('Qargs<bar>:argdo %', '[execute]\|q: ', '') . '<cr>'

function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" list all syntax symbols at cursor. useful for setting highlight groups
" obsoleted by treesitter-playground
nnoremap <leader>. :call SynStack()<cr>

]])

-- LSP bindings (see lsp_on_attach for bindings only set after LSP server is attached to buffer)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {noremap=true, silent=true})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {noremap=true, silent=true})
vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', {noremap=true, silent=true})
vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', {noremap=true, silent=true})
vim.keymap.set('n', '<leader>te', vim.diagnostic.open_float, {noremap=true, silent=true})
vim.keymap.set('n', '<leader>tE', vim.diagnostic.setloclist, {noremap=true, silent=true})

vim.keymap.set('n', '<leader>to', '<cmd>SymbolsOutline<CR>')

-- statusline
vim.opt.statusline = ''
.. '[%n]'                                  -- buffernr
-- TODO: change the color for modified
.. '%#Todo#%m%r%w%*'                       -- modified/readonly
.. '%#LineNr#%{FugitiveHead()}%*'          -- git branch
.. ' %<%F '                               -- File+path
.. '%* %= '                               -- divider
.. '%{luaeval("_G.lsp_current_function()")} '               -- LSP current function
.. '%#Todo#%{luaeval("_G.lsp_status_diagnostics()")}%* '
.. "%{''.(&fenc!=''?&fenc:&enc).''}"        -- Encoding
.. '%{(&bomb?\",BOM\":\"\")}'            -- Encoding2
.. '[%{&ff}] '                              -- FileFormat (dos/unix..)
.. '%y '                                 -- FileType
.. '0x%04B '          -- character under cursor
.. '%l:%v '  -- row:col
.. '%p%% '  -- row %
-- .. '%P  '                      -- Modified? Readonly? Top/bot.

-- Additional plugin configuration
vim.cmd([[
let g:ackprg = 'ag --nogroup --nocolor --column --hidden --path-to-ignore ' . $HOME . '/.config/ag/.ignore'
]])

-- Unsued
--[[
--neotags/ctags
-- add IDF headers to path
if isdirectory($IDF_PATH)
    set path+=$IDF_PATH/components/**1/include
endif
--]]

-- Colors
-- must be defined after tree-sitter setup so it doesn't override links in our colorscheme
vim.cmd([[
colorscheme burgundy

hi ScrollView guifg=#f2c9db guibg=#4a1027 guisp=#4a1027 gui=NONE ctermfg=224 ctermbg=237 cterm=NONE
hi FocusedSymbol gui=bold,italic cterm=bold,italic

" hi WildMenu guifg=#f7f7f7 guibg=#611835 guisp=#611835 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
" hi LineNr guifg=#9e0c46 guibg=#240d19 guisp=#240d19 gui=NONE ctermfg=125 ctermbg=235 cterm=NONE

hi link TSProperty Normal
hi link TSParameter Normal
" hi link TSConstructor Identifier
" hi link TSConstructor Function
" hi link TSVariableBuiltin Identifier

]])

