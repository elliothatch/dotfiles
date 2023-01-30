" Setup {{{
set shellslash

let g:HomeDir='/home/ellioth/'
" python support setup
let g:python3_host_prog=g:HomeDir . '.local/virtualenvs/neovim3/bin/python'
let g:python_host_prog=g:HomeDir . '.local/virtualenvs/neovim2/bin/python'

" sheerun/vim-polyglot
let g:polyglot_disabled = ['typescript', 'csv']
" }}}
" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')


" core
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" use vim-specific fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'

" editor
"Plug 'scrooloose/nerdcommenter'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'tag': '4.0-serial' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-commentary'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-compe'

Plug 'nvim-lua/lsp-status.nvim'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" coc extensions
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}

" git
Plug 'tpope/vim-fugitive'

" grep
Plug 'mileszs/ack.vim'

" folding
Plug 'nelstrom/vim-markdown-folding'

" visual
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'elliothatch/burgundy.vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'joelstrouts/swatch.vim'
Plug 'dstein64/nvim-scrollview'

" uses ctags (https://github.com/universal-ctags/ctags)
"Plug 'majutsushi/tagbar'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'chrisbra/Colorizer'

Plug 'mbbill/undotree'

" syntax
"Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
"Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'rust-lang/rust.vim'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mustache/vim-mustache-handlebars'

" tags
" Plug 'c0r73x/neotags.nvim', {'do': 'make'}
" Plug 'liuchengxu/vista.vim'
" lsp symbol outline. i may use this more if they implement ability to
" customize symbols, filter outline to certain types of symbols (just classes
" and functions, etc
Plug 'simrat39/symbols-outline.nvim'

" typescript
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"Plug 'mhartington/nvim-typescript', {'commit': 'b1d61b22d2459f1f62ab256f564b52d05626440a'}
" Plug 'elliothatch/nvim-typescript' " slightly modified old version that works on windows

" debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" c
Plug 'vim-scripts/headerguard'

" nyaovim
" Plug 'rhysd/nyaovim-markdown-preview'

"Plug 'D:/workspace/nyaovim-color-picker'

call plug#end()
" }}}
"  - Options {{{
" 'hrsh7th/nvim-compe'
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
" let g:compe.preselect = 'always'
let g:compe.preselect = 'never'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = {}
let g:compe.source.buffer.menu = '[B]'
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = {}
let g:compe.source.nvim_lsp.menu = '[L]'
let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

inoremap <silent><expr> <C-Space> compe#complete()
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  -- elseif vim.fn['vsnip#available'](1) == 1 then
  --   return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  -- elseif vim.fn['vsnip#jumpable'](-1) == 1 then
  --   return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

" vim-airline/vim-airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='luna'
"
"let g:airline_powerline_fonts = 1
"let g:airline_extensions = ['tabline']

" neomake/neomake
let g:neomake_open_list = 2

" Shougo/deoplete.nvim
" let g:deoplete#enable_at_startup = 1

" elliothatch/nvim-typescript
" let g:nvim_typescript#_server_path = 'node_modules\\.bin\\tsserver'

let g:neomake_html_enabled_makers = []
let g:neomake_c_enabled_makers  = ['makeprg']
let g:neomake_cpp_enabled_makers  = ['makeprg']

" neoclide/coc
"
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" nnoremap <silent> <leader>tm :call <SID>show_documentation()<CR>
" nmap <silent> <leader>tr <Plug>(coc-references)
" nmap <silent> <leader>tR <Plug>(coc-rename)
" nmap <silent> <leader>td <Plug>(coc-definition)
" nmap <silent> <leader>tD <Plug>(coc-type-definition)
" nmap <silent> <leader>ti <Plug>(coc-implementation)
" nmap <silent> <leader>t[ <Plug>(coc-diagnostic-next)
" nmap <silent> <leader>t] <Plug>(coc-diagnostic-prev)
" nmap <silent> <leader>t/ :CocList outline<CR>
" nmap <silent> <leader>te :CocList diagnostics<CR>
" nmap <silent> <leader>ta :CocAction<CR>

" nnoremap <leader>tt :TSType<CR>
" nnoremap <leader>ti :TSImport<CR>
" nnoremap <leader>ts :TSTypePreview<CR>

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" liuchengxu/vista
" let g:vista_default_executive = 'coc'
" let g:vista_executive_for = {
" \ 'c': 'ctags',
" \ 'cpp': 'ctags',
" \}

" disable icons since I don't use nerdfonts
" let g:vista#renderer#enable_icon = 0

" nnoremap <leader>to :Vista!!<cr>
" nnoremap <leader>tf :Vista finder<cr>


" let esp32Maker = {'name': 'esp32 c compiler'}
" function! esp32Maker.get_list_entries(jobinfo) abort
"       return [
"         \ {'text': 'Some error', 'lnum': 1, 'bufnr': a:jobinfo.bufnr},
"         \ {'text': 'Some warning', 'type': 'W', 'lnum': 2, 'col': 1,
"         \  'length': 5, 'filename': '/path/to/file'},
"         \ ]
"   endfunction

"let g:tagbar_type_css = {
"\ 'ctagstype' : 'Css',
    "\ 'kinds'     : [
        "\ 'c:classes',
        "\ 's:selectors',
        "\ 'i:identities'
    "\ ]
"\ }

"let g:tagbar_type_typescript = {                                                  
  "\ 'ctagsbin' : 'tstags',                                                        
  "\ 'ctagsargs' : '-f-',                                                           
  "\ 'kinds': [                                                                     
    "\ 'e:enums:0:1',                                                               
    "\ 'f:function:0:1',                                                            
    "\ 't:typealias:0:1',                                                           
    "\ 'M:Module:0:1',                                                              
    "\ 'I:import:0:1',                                                              
    "\ 'i:interface:0:1',                                                           
    "\ 'C:class:0:1',                                                               
    "\ 'm:method:0:1',                                                              
    "\ 'p:property:0:1',                                                            
    "\ 'v:variable:0:1',                                                            
    "\ 'c:const:0:1',                                                              
  "\ ],                                                                            
  "\ 'sort' : 0                                                                    
"\ }     

" }}}
"  - Setup {{{
"
" Shougo/denite.nvim
" add git ls-files source
"call denite#custom#alias('source', 'file_rec/git', 'file_rec')
"call denite#custom#var('file_rec/git', 'command',
"\ ['git', 'ls-files', '-co', '--exclude-standard'])
"nnoremap <silent> <C-p> :<C-u>Denite
"\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

" move cursor up/down with Ctrl-j and Ctrl-k
"call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
"call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" neomake/neomake
" automatically run on load and save
"call neomake#configure#automake('rw', 1000)
" }}}
"  - Bindings {{{
" scrooloose/nerdcommenter
"nmap <leader>/ <leader>c<Space>
"vmap <leader>/ <leader>c<Space>

" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Shougo/denite.nvim
"nnoremap <C-p> :<C-u>Denite file_rec/git<CR>
"nnoremap <C-Space> :<C-u>Denite buffer<CR>

" junegunn/fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-Space> :Buffers<CR>

" tpope/vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gU :Gread<CR>
nnoremap <leader>gc :Gcommit<CR>
" run these commands in a separate tab, auto open the quickfix list
nnoremap <leader>gl :tabe %<CR>:NeomakeDisableTab<CR>:Glog -- %<CR>:botright copen<CR>
nnoremap <leader>gL :tabe %<CR>:NeomakeDisableTab<CR>:Glog<CR>:botright copen<CR>
nnoremap <leader>gd :tabe %<CR>:NeomakeDisableTab<CR>:Gdiff<CR>
nnoremap <leader>gb :tabe %<CR>:NeomakeDisableTab<CR>:Gblame<CR>

" build project
nnoremap <leader>b :Neomake<cr>

" format json
nnoremap <leader>fj :%! python -m json.tool<CR>
vnoremap <leader>fj :! python -m json.tool<CR>

" convert (format) to hex
nnoremap <expr> <leader>fh :%!od -A x -t x1z -v<CR>

" mileszs/ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column --hidden --path-to-ignore ' . g:HomeDir . '.config/ag/.ignore'
"vnoremap <Leader>av :<C-u>let cmd = "Ack! " . VAck() <bar> call histadd("cmd", cmd) <bar> execute cmd<CR>

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


" elliothatch/nvim-typescript

" nnoremap <leader>td :TSDef<CR>
" nnoremap <leader>tD :TSTypeDef<CR>
" nnoremap <leader>tt :TSType<CR>
" nnoremap <leader>ti :TSImport<CR>
" nnoremap <leader>tm :TSDoc<CR>
" nnoremap <leader>ts :TSTypePreview<CR>

" }}}
" Editor Settings {{{
set hidden
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set copyindent                  " carry indentation on newline
set incsearch                   " search as you type
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set undofile                    " save undo history to file
set textwidth=0                 " disable automatic word wrap
" set completeopt+=noinsert       " auto-select first omnicomplete result
set completeopt=menuone,noselect
set mouse=a                     " enable mouse
set title                       " set window title

" these are supposed to help with autocmd FileType not triggering but they
" don't fix the issue
" filetype plugin indent on
" set shortmess-=F
" }}}
"  - Make settings {{{
" set errorformat+=%f:%l:%c:\ %trror:\ %m
" neotags
let g:neotags_ignore = [
		\ 'text',
		\ 'nofile',
		\ 'mail',
		\ 'qf',
		\ 'fzf'
		\ ]
" let g:neotags_events_update = ['BufWritePost', 'BufReadPre']
" let g:neotags_ctags_args = [
" 		\ '--fields=+l',
" 		\ '--c-kinds=+p',
" 		\ '--c++-kinds=+p',
" 		\ '--sort=yes',
" 		\ '--extras=+q'
" 		\ ]

" let g:neotags_directory = '~/.vim_tags'
if isdirectory($IDF_PATH)
    set path+=$IDF_PATH/components/**1/include
endif
" }}}
"  - Clipboard settings {{{
set clipboard+=unnamedplus
" let g:clipboard = {
" 	\'name': 'wl-clipboard',
" 	\   'copy': {
" 	\      '+': 'wl-copy',
" 	\      '*': 'wl-copy',
" 	\    },
" 	\   'paste': {
" 	\      '+': 'wl-paste --no-newline',
" 	\      '*': 'wl-paste --no-newline --primary',
" 	\   },
" 	\'cache_enabled': 1,
" \}
" }}}
"  - Folding {{{

set foldlevelstart=2

" focus the current line (close all folds except this one, then center the
" screen)
nnoremap <leader>z zMzvzz

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! MyFoldText() " {{{
    let l:line = getline(v:foldstart)

    let l:nucolwidth = &foldcolumn + &number * &numberwidth
    let l:windowwidth = winwidth(0) - l:nucolwidth
    let l:foldedlinecount = v:foldend - v:foldstart

    let l:rightcoltext = '|' . repeat(' ', l:nucolwidth - len(l:foldedlinecount)) . l:foldedlinecount . '|'

    " expand tabs into spaces
    let l:onetab = strpart('          ', 0, &tabstop)
    let l:line = substitute(l:line, '\t', l:onetab, 'g')

    let l:minwidth = &colorcolumn-1
    " pad with whitespace
	"let leftcolbuffer = 10
    "let l:line = l:line . ' ' . repeat(" ", leftcolbuffer)
	if len(l:line) < l:minwidth
		let l:line = l:line . repeat(' ',(l:minwidth)-len(l:line))
	endif
    let l:line = strpart(l:line, 0, l:windowwidth - len(l:rightcoltext)-2)

	" TODO: write generic flexible column functions
	" TODO: make this display some simple outline view (e.g. language symbols for class, function, interface, etc
	"let centercolcontent = ''
	"if v:foldstart == 1
		"let centercolcontent = @%
	"endif

	"let currentlineno = v:foldstart+1
	"let i = 0
	"while i < 5
		"let currentline = Strip(getline(currentlineno))
		"if len(currentline) > 1
			"let centercolcontent = substitute(currentline, '\t', onetab, 'g')
			"break
		"endif
		"let i = i + 1
	"endwhile
	let l:fillcharcount = l:windowwidth - len(l:line) - len(l:rightcoltext)
	"let l:centercolcontent = ''
	"let l:centercoltext = l:centercolcontent . ' ' . repeat(' ', l:fillcharcount-len(l:centercolcontent))
	"let centercolcontent = centercolcontent . ' ' . repeat(' ', fillcharcount-len(centercolcontent)-2)
	"let centercoltext = strpart('|' . centercolcontent, 0, fillcharcount)

	return l:line . repeat(' ', l:fillcharcount) . l:rightcoltext
    "return l:line . l:centercoltext . l:rightcoltext
endfunction " }}}

set foldtext=MyFoldText()
" }}}
"  - Ack {{{
" set grep to ack
set grepprg=ack\ -k
"}}}
"  - Visual {{{
set number                      " show line numbers
set showmatch                   " show matching parentheses
set matchtime=2                 " ms to show matching parens in showmatch
set list
set listchars=tab:▸-,trail:.,extends:❯,precedes:❮
"eol:¬,
set showbreak=↪
set cursorline                  " hilight current line
set scrolloff=3                 " scroll before cursor is at edge of screen
set colorcolumn=81
set lazyredraw
set termguicolors

set inccommand=split " live substitution with search matches shown in split
colorscheme burgundy

" Extended custom colors
hi ScrollView guifg=#f2c9db guibg=#4a1027 guisp=#4a1027 gui=NONE ctermfg=224 ctermbg=237 cterm=NONE

hi FocusedSymbol gui=bold,italic cterm=bold,italic

" hi WildMenu guifg=#f7f7f7 guibg=#611835 guisp=#611835 gui=NONE ctermfg=15 ctermbg=52 cterm=NONE

" hi LineNr guifg=#9e0c46 guibg=#240d19 guisp=#240d19 gui=NONE ctermfg=125 ctermbg=235 cterm=NONE
"
hi link TSProperty Normal
hi link TSParameter Normal
" hi link TSConstructor Identifier
" hi link TSConstructor Function
" hi link TSVariableBuiltin Identifier

" }}}
" Autocommands {{{
function! RemoveBufferIfPreview()
    if &previewwindow
        set nobuflisted
    endif
endf

function! LoadIncludes()
	let l:PreReadIncludePaths = systemlist('cat ' . expand('%p') . ' | grep "#include" | sed -e ''s/.*"\(.*\)".*/\1/'' | sed -e ''s/.*<\(.*\)>.*/\1/''')
	" neotags needs some time on each buffer before it triggers ctags?
	" neovim ofetn doesn't even display the tab or buffers
	execute 'tabnew'
	for filePath in l:PreReadIncludePaths
		execute 'sfind ' . filePath
		execute 'sleep 10m'
		execute 'bd'
		" let l:tagFile = g:neotags_directory . '/' . substitute(filePath, '/\//', '__', 'g')
		" call system('ctags ' . join(g:neotags_ctags_args, ' ') . ' -f "' . l:tagFile . '" "' . filePath . '"')
	endfor
	execute 'sleep 400m'
	execute 'tabc'
endf

function! FoldOutline(lnum)
	let l:line = getline(v:lnum)
	let l:nextline = getline(v:lnum + 1)

	let l:linematch = matchstrpos(l:line,  '.*[├└]')
	let l:nextlinematch = matchstrpos(l:nextline,  '.*[├└]')

	let l:linelevel = 0
	if l:linematch[2] >= 0
		let l:linelevel = max([1, (l:linematch[2] - 2)/4 + 1])
	endif

	let l:nextlinelevel = 0
	if l:nextlinematch[2] >= 0
		let l:nextlinelevel = max([1, (l:nextlinematch[2] - 2)/4 + 1])
	endif

	if l:nextlinelevel > l:linelevel
		return l:nextlinelevel
	endif

	return l:linelevel
endfunction

augroup myautocmds
	" automatically add the current extension to 'gf' paths
	autocmd!
	autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
	" make  '-' part of words in css files
	autocmd FileType css,sass,scss execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted
	" use spaces instead of tabs in certain filetypes
	autocmd FileType typescript execute 'setl expandtab'
	" autocmd FileType typescript execute 'setl expandtab'
	" autocmd FileType typescript execute 'nnoremap <buffer> <silent> <leader>tI :CocCommand tsserver.organizeImports<cr>'
	" don't add preview window buffers to buffer list
	autocmd BufEnter * call RemoveBufferIfPreview()
	" autocmd BufReadPre * call PreReadIncludes()
	" autocmd BufEnter c,cpp call LoadIncludes()
	" autocmd FileType c,cpp set makeprg=BATCH_BUILD=1\ make
	
	autocmd FileType c,cpp execute 'setl makeprg=idf.py\ build'

	" simrat39/symbols-outline.nvim
	" outline uses comment highlight group for vertical pipes, turn off italics
	autocmd FileType Outline execute 'hi Comment gui=NONE cterm=NONE'
	autocmd FileType Outline execute 'hi Folded guifg=#f2ead7 guibg=#1a0a16 guisp=#1a0a16 gui=NONE ctermfg=230 ctermbg=234 cterm=NONE'
'
'
	autocmd FileType Outline execute 'setl foldlevel=1|setl foldexpr=FoldOutline(v:lnum)|setl foldmethod=expr'
	" dap
	autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
	" dap-ui
	" WHY DOESN'T dapui* work???
	autocmd FileType dapui* setl statusline=[%n]%f
	autocmd FileType dap-repl setl statusline=[%n]%f
augroup END
" }}}
" Filetypes {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker keywordprg=:help
    au FileType help setlocal textwidth=78
	au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}
" LSP {{{
lua << EOF
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}
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

local nvim_lsp = require('lspconfig')
 -- configure diagnostic marks
-- vim.fn.sign_define("LspDiagnosticsSignError",
--     {text = "", texthl = "GruvboxRed"})
-- vim.fn.sign_define("LspDiagnosticsSignWarning",
--     {text = "", texthl = "GruvboxYellow"})
-- vim.fn.sign_define("LspDiagnosticsSignInformation",
--     {text = "", texthl = "GruvboxBlue"})
-- vim.fn.sign_define("LspDiagnosticsSignHint",
--     {text = "", texthl = "GruvboxAqua"})
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "✖"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "❗"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "🛈"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "❓"})

local lsp_status = require('lsp-status')

local indicator_ok = '✔'
local component_separator = ' | '

lsp_status.config({
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

	-- status_symbol = '',
	-- indicator_errors = '',
	-- indicator_warnings = '',
	-- indicator_info = ' ',
	-- indicator_hint = '',
	-- indicator_ok = '✔',
	-- indicator_separator = ' ',


	-- status_symbol = '',
	-- indicator_errors = ' ',
	-- indicator_warnings = '⚠',
	-- indicator_info = '🛈 ',
	-- indicator_hint = '⚠ ',
	--indicator_ok = '✓',
})
lsp_status.register_progress()

local capabilities = vim.tbl_extend('keep', vim.lsp.protocol.make_client_capabilities(), lsp_status.capabilities)

function _G.lsp_status_function()
	local current_function = vim.b.lsp_current_function
	if current_function and current_function ~= '' then
		return '(' .. current_function .. ')'
	end

	return ''
end

function _G.lsp_status_diagnostics()
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


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- buf_set_keymap('n', '<leader>td', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', '<leader>td', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>tm', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', '<leader>ti', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<leader>tD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>tR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>ta', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>tr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<leader>te', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({})<CR>', opts)
	buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
	buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
	buf_set_keymap('n', '<leader>tE', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap("n", "<leader>t=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	buf_set_keymap("n", "<leader>to", "<cmd>SymbolsOutline<CR>", opts)

	if client.supports_method('textDocument/documentHighlight') then
		-- highlight symbol under cursor
		vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
		vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
		vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
	end

	lsp_status.on_attach(client, bufnr)
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- for k,v in pairs(lsp_status.capabilities) do capabilities[k] = v end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
    	on_attach = on_attach,
    	flags = {
    		debounce_text_changes = 150,
		}
	}

	if server.name == "pylsp" then
		opts.settings = {
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
	end

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- require'lspconfig'.tsserver.setup{}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "pyright", "rust_analyzer", "tsserver" }
-- local servers = { "tsserver" }
-- for _, lsp in ipairs(servers) do
-- 	nvim_lsp[lsp].setup {
-- 		on_attach = on_attach,
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 			}
-- 		}
-- end

local lsp_installer = require "nvim-lsp-installer"

local servers = {
	'bashls',
	'ccls',
	'clangd',
	'cmake',
	'cssls',
	'dockerls',
	'gopls',
	'html',
	'intelephense',
	'jsonls',
	'ltex',
	'pylsp',
	'solargraph',
	'sqlls',
	'sumneko_lua',
	'tsserver',
	'vimls',
	'yamlls',
	--'tailwindcss',
}

function _G.lsp_install_missing()
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found then
			if not server:is_installed() then
				print("Installing " .. name)
				server:install()
			end
		end
	end
end

function _G.set_difference(a, b)
    local aa = {}
    for k,v in pairs(a) do aa[v]=true end
    for k,v in pairs(b) do aa[v]=nil end
    local ret = {}
    local n = 0
    for k,v in pairs(a) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

vim.cmd("command! LspInstallMissing lua lsp_install_missing()")

-- " }}}
-- " treesitter {{{
-- treesitter ------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
	highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
	},
	indent = {
	enable = true
	},
	incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "gnn",
		--node_incremental = "grn",
		scope_incremental = "grc",
		node_decremental = "grm",
		},
	},
	custom_captures = {
		-- remove the "constructor" highlight capture because nvim-treesitter annoyingly assumes any identifier starting with a capital letter is a constructor
		-- this doesn't seem to work, so I removed the @constructor and @constant queries by invoking :TSEditQuery highlights and commenting out the relevant lines from ECMA
		-- this hopefully won't be necessary after this issue is merged https://github.com/nvim-treesitter/nvim-treesitter/pull/1556
		--['constructor'] = nil
	},
	--ensure_installed = 'all'
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
}
 -- set foldmethod=expr
 -- set foldexpr=nvim_treesitter#foldexpr()

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- " }}}
-- " nvim-dap {{{
local dap = require('dap')

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
}
-- " }}}
-- " nvim-dap-ui {{{
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
      } },
})


vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})


-- on launch, open the console
dap.listeners.after['launch']['on_launch'] = function(session)
	dapui.open(3)
end

-- on stop (e.g. hit breakpoint) open the debug panes
dap.listeners.after['event_stopped']['on_stop'] = function(session, body)
	dapui.close(3)
	dapui.open(1)
	dapui.open(2)
end

-- on process exit close the debug panes, but open the console to view debugee output
dap.listeners.after['event_exited']['on_exit'] = function(session, body)
	dapui.close(1)
	dapui.close(2)
	dapui.open(3)
end
	
	
-- " }}}

EOF

function! LspStatusFunction() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
	  return luaeval("lsp_status_function()")
  endif

  return ''
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("lsp_status_diagnostics()")
  endif

  return ''
endfunction

" statusline
set statusline=
set statusline+=[%n]                                  "buffernr
" TODO: change the color for modified
set statusline+=%#Todo#%m%r%w%*                           " modified/readonly
"set statusline+=%#LineNr#%{fugitive#statusline()}%*             " git branch
set statusline+=%#LineNr#%{FugitiveHead()}%*             " git branch
set statusline+=\ %<%F\                                "File+path
set statusline+=%*\ %=\  "divider
set statusline+=%{LspStatusFunction()}\ 
set statusline+=%#Todo#%{LspStatus()}%*\ 
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}            "Encoding2
set statusline+=[%{&ff}]\                              "FileFormat (dos/unix..)
set statusline+=%y\                                  "FileType
" set statusline+=%{SpinnerText()}
set statusline+=0x%04B\          "character under cursor
set statusline+=%l:%v\  "row:col
set statusline+=%p%%\  "row %
"set statusline+=%P\ \                      "Modified? Readonly? Top/bot.

" }}}
" Bindings {{{
map <space> <leader>
map <space><space> <leader><leader>

"map \ <leader>
"map \\ <localleader><localleader>

nnoremap <leader>w :w<cr>
" map <tab> %

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

" load all c/c++ #include directives into buffers on another tab, so neotags
" indexes them, then close the tab.
nnoremap <leader>L :call LoadIncludes()<cr>

" }}}
"  - Buffers {{{
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>n :enew<cr>
" close buffer without closing the window
" switch to alternate buffer and close the buffer we were just on
" if the alternate buffer is unlisted, go to the previous buffer instead
" if we are closing the last listed buffer, create a new blank buffer to switch to
nnoremap <expr> <leader>q len(getbufinfo({'buflisted':1})) == 1 ? ':enew<cr>:bd#<cr>' : (buflisted(bufnr('#')) ? ':b #<cr>:bd #<cr>' : ':bp<cr>:bd #<cr>')

" }}}
"  - Navigation {{{
" visual cursor movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" don't use this command because it gets netrw in a weird state
"nnoremap <leader>e :e.<cr>
nnoremap <leader>e :E<cr>
nnoremap <expr> <leader>E ':E ' . getcwd() . '<cr>'

" Keep search matches in the middle of the window.
"nnoremap n nzzzv
"nnoremap N Nzzzv

" Easier to type
noremap H ^
noremap L $
vnoremap L g_

cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" }}}
"  - Visual Mode {{{
vnoremap > >gv
vnoremap < <gv

vnoremap <leader>s :sort<CR>

" fix linewise visual selection
"nnoremap VV V
"nnoremap Vit vitVkoj
"nnoremap Vat vatV
"nnoremap Vab vabV
"nnoremap VaB vaBV

" select contents of current line, excluding indentation
nnoremap vv ^vg_
" }}}
"  - Windows {{{
nnoremap <leader>Q :close<cr>

" split
noremap <leader>v <C-w>v<C-w>l
noremap <leader>V <C-w>S<C-w>j

" Map ctrl-movement keys to window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>

" diff current window
" nnoremap <leader>d :diffthis<cr>
"}}}
"  - Folding {{{
"  Fold comments
noremap <silent> <leader>zc :set foldmethod=expr<cr>:set foldexpr=synIDattr(synID(v:lnum,strlen(getline(v:lnum)),1),'name')=~?'comment'?'1':getline(v:lnum)=~'^\\s*$'?'=':'0'<cr>zM<cr>
"}}}
"  - Quickfix List {{{
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

" puts quickfix files in args
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let l:buffer_numbers = {}
  for l:quickfix_item in getqflist()
    let l:buffer_numbers[l:quickfix_item['bufnr']] = bufname(l:quickfix_item['bufnr'])
  endfor
  return join(map(values(l:buffer_numbers), 'fnameescape(v:val)'))
endfunction

" run command on each file in quickfix
" to save changes, run :argdo update
nnoremap <expr> <leader>r InputOrCancel('Qargs<bar>:argdo %', '[execute]\|q: ', '') . '<cr>'
" }}}
"  - Terminal Mode {{{
" map ctrl-movement keys to switch windows (can be used to exit terminal mode quickly)
tnoremap <C-k> <C-\><C-N><C-w><Up>
tnoremap <C-j> <C-\><C-N><C-w><Down>
tnoremap <C-l> <C-\><C-N><C-w><Right>
tnoremap <C-h> <C-\><C-N><C-w><Left>

" }}}
"  - Other {{{
function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>. :call SynStack()<cr>
" }}}
" Misc {{{
" Map insert mdoe keys to insert the autocomplete match when typed
function! AutocompleteOnSymbol(char) "{{{
if pumvisible()
	return "\<c-y>\<c-r>='" . a:char . "'\<cr>"
else
	return a:char
endif
endfunction "}}}
function! InputOrCancel(prefix, prompt, suffix) "{{{
	call inputsave()
	let l:result = input(a:prompt)
	if l:result == ''
		return '<cr>'
	endif
	call inputrestore()
	let l:cmd = a:prefix . l:result . a:suffix
	call histadd('cmd', l:cmd)
	return ':' . l:cmd
endfunc "}}}

function! AutocompleteOnInsertChar(chars)
	for l:char in a:chars
		execute 'inoremap <silent> <expr> ' . l:char . ' AutocompleteOnSymbol("'.l:char.'")'
	endfor
endfunction

" neomake spinner
let s:spinner_index = 0
let s:active_spinners = 0
let s:spinner_states = ['|', '/', '-', '\', '|', '/', '-', '\']

function! StartSpinner()
    let b:show_spinner = 1
    let s:active_spinners += 1
    if s:active_spinners == 1
        let s:spinner_timer = timer_start(1000 / len(s:spinner_states), 'SpinSpinner', {'repeat': -1})
    endif
endfunction

function! StopSpinner()
    let b:show_spinner = 0
    let s:active_spinners -= 1
    if s:active_spinners == 0
        :call timer_stop(s:spinner_timer)
    endif
endfunction

function! SpinSpinner(timer)
    let s:spinner_index = float2nr(fmod(s:spinner_index + 1, len(s:spinner_states)))
    redraw
endfunction

function! SpinnerText()
    if get(b:, 'show_spinner', 0) == 0
        return " "
    endif

    return s:spinner_states[s:spinner_index]
endfunction

augroup neomake_hooks
    au!
    autocmd User NeomakeJobInit :call StartSpinner()
    " autocmd User NeomakeJobInit :echom "Build started"
    autocmd User NeomakeFinished :call StopSpinner()
    " autocmd User NeomakeFinished :echom "Build complete"
augroup END

"call AutocompleteOnInsertChar([
"\'(', ')', '[', ']',
"\';', ',', '.',  ':',
"\'!', '='])
"
" }}}

" nvim-dap {{{
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
" }}}
" nvim-dap-ui {{{
nnoremap <silent> <leader>do <Cmd>lua require'dapui'.open()<CR>
" }}}
