set shellslash
set runtimepath^=~/.vim  "Use instead of "vimfiles" on windows

" VIM SETTINGS
set nocompatible
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set mouse=a

"source ~/.vim/work.vim

set history=1000                " large command history
set undolevels=1000             " large undo history
set undodir=~/.vim/undo         " persistent undo
set undofile

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp,.

set autoindent                  " carry indentation on newline
set hlsearch                    " highlight seach
set showcmd                     " display incomplete commands
set wildmenu                    " show a menu of completions
set wildmode=full               " complete longest common prefix first
set wrap

" PLUGIN SETTINGS

" OMNICOMPLETE SETTINGS
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone

" AUTOCOMPLPOP SETTINGS
let g:acp_behaviorTypescriptOmniLength = 0
function! AcpMeetsForTypescriptOmni(context)
  return g:acp_behaviorPythonOmniLength >= 0 &&
        \ a:context =~ '\k\.\k\{' . g:acp_behaviorTypescriptOmniLength . ',}$'
endfunction

let behavs = {
	\'typescript': [{
		\'command': "\<C-x>\<C-o>",
		\'meets': 'AcpMeetsForTypescriptOmni',
		\'repeat': 1
	\}]
\}

" add keyword and file autocomplete to all custom behaviors
"<C-n> below is the default value for g:acp_behaviorKeywordCommand
for key in keys(behavs)
	call add(behavs[key], {
	\   'command' : "\<C-n>",
	\   'meets'   : 'acp#meetsForKeyword',
	\   'repeat'  : 0,
	\ })
endfor
"---------------------------------------------------------------------------
for key in keys(behavs)
	call add(behavs[key], {
	\   'command' : "\<C-x>\<C-f>",
	\   'meets'   : 'acp#meetsForFile',
	\   'repeat'  : 1,
	\ })
endfor

if !exists("g:acp_behavior")
	let g:acp_behavior = {}
endif

call extend(g:acp_behavior, behavs, "force")

" SYNTASTIC SETTINGS
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" tsuquyomi settings
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:tsuquyomi_completion_detail = 1 "may cause slowdown
let g:tsuquyomi_shortest_import_path = 1

" C++ SETTINGS
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -pedantic"

" HTML TIDY SETTINGS
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" CTRL-P SETTINGS
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/](build|[.]git|node_modules|bower_components|dist|.sass-cache|Godeps)$',
\ 'file': '\v\.(DS_Store)$' }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ctrlp_max_files = 50000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_lazy_update = 100

" load plugins with vim-plug
call plug#begin('~/.local/share/vim/plugged')

" core
Plug 'scrooloose/syntastic'

" editor
Plug 'scrooloose/nerdcommenter'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/AutoComplPop'
Plug 'kien/ctrlp.vim'

" git
Plug 'tpope/vim-fugitive'

" grep
 Plug 'mileszs/ack.vim'

" visual
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'elliothatch/burgundy.vim'

Plug 'chrisbra/Colorizer'

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" typescript
Plug 'Quramy/tsuquyomi'

call plug#end()

" EDITOR SETTINGS
set hidden
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set copyindent                  " carry indentation on newline
set clipboard=unnamed
set incsearch                   " search as you type
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set undofile                    " save undo history to file
set textwidth=0                 " disable automatic word wrap

" DISPLAY SETTINGS
set number                      " show line numbers
set showmatch                   " show matching parentheses
set matchtime=2                 " ms to show matching parens in showmatch
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
set laststatus=2
set cursorline                  " hilight current line
set scrolloff=3                 " scroll before cursor is at edge of screen
set colorcolumn=81

" AUTOCMDS
augroup myautocmds
	" automatically add the current extension to 'gf' paths
	autocmd!
	autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
	" make  '-' part of words in css files
	autocmd FileType css,sass execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted

	" make settings
	autocmd FileType tex setlocal makeprg=texfot\ pdflatex\ --shell-escape\ -interaction=nonstopmode\ %

	" TYPESCRIPT SPECIFIC COMMANDS
	autocmd FileType typescript map <buffer> <leader>i :TsuImport<cr>
augroup END

" BINDINGS
" use space as mapleader (silent off)
map <space> <leader>
map <space><space> <leader><leader>

" NORMAL MODE
" window bindings
nnoremap <leader>Q :q<cr>

" Map ctrl-movement keys to window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

" toggle paste mode
set pastetoggle=<leader>p

" save
nnoremap <leader>w :w<cr>

" buffer bindings
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>n :enew<cr>

" wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cl :cnext<cr>
nnoremap <leader>ch :cprevious<cr>

" location list
nnoremap <leader>Co :lopen<cr>
nnoremap <leader>Cl :lnext<cr>
nnoremap <leader>Ch :lprevious<cr>

" set grep to ack
set grepprg=ack\ -k

" get highlight group under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>. :call SynStack()<cr>

" VISUAL MODE
" don't exit visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" PLUGIN BINDINGS
" scrooloose/nerdcommenter
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" scrooloose/nerdtree
"" open file explorer
nnoremap <leader>F :NERDTreeToggle<cr>

" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" tpope/vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gU :Gread<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" mileszs/ack.vim
function! InputOrCancel(prefix, prompt, suffix)
	call inputsave()
	let result = input(a:prompt)
	if result == ''
		return '<cr>'
	endif
	call inputrestore()
	return a:prefix . result . a:suffix
endfunc

"nnoremap <expr> <leader>ss ':Ack! '          . input('[ack]: ')              . ' ' . expand('%:p:h') . '<cr>'
nnoremap <expr> <leader>ss InputOrCancel(':Ack! ',    '[ack]: ',       ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>sl InputOrCancel(':LAck ',    '[ack]\|L: ', ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>sf InputOrCancel(':AckFile ', '[ack file]: ', ' ' . expand('%:p:h') . '<cr>')
nnoremap <expr> <leader>s/ ':AckFromSearch ' . expand('%:p:h') . '<cr>'

nnoremap <expr> <leader>Ss InputOrCancel(':Ack! ',    '[ack project]: ',       '<cr>')
nnoremap <expr> <leader>Sl InputOrCancel(':LAck ',    '[ack project]\|L: '), '<cr>')
nnoremap <expr> <leader>Sf InputOrCancel(':AckFile ', '[ack project file]: '), '<cr>')
nnoremap <expr> <leader>S/ ':AckFromSearch ' . '<cr>'

function! MakeAndShowErrors()
	make
	if v:shell_error
		copen
	endif
endfunction

" VISUAL SETTINGS
colorscheme burgundy

" GVIM SETTINGS
set guifont=Source_Code_Pro:h11:cANSI
set guioptions-=T " remove toolbar

" statusline
set statusline=
set statusline+=[%n]                                  "buffernr
" TODO: change the color for modified
set statusline+=%#DiffChange#%m%r%w%*                           " modified/readonly
"set statusline+=%#LineNr#%{fugitive#statusline()}%*             " git branch
set statusline+=%#LineNr#%{fugitive#head()}%*             " git branch
set statusline+=\ %<%F\                                "File+path
set statusline+=%*\ %=\  "divider
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}            "Encoding2
set statusline+=[%{&ff}]\                              "FileFormat (dos/unix..)
set statusline+=%y\                                  "FileType
set statusline+=0x%04B\          "character under cursor
set statusline+=%l:%v\  "row:col
set statusline+=%p%%\  "row %
"set statusline+=%P\ \                      "Modified? Readonly? Top/bot.
