set runtimepath^=~/.vim  "Use instead of "vimfiles" on windows
runtime bundle/vim-pathogen/autoload/pathogen.vim

set nocompatible
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set mouse=a

"windows -- use forward slashes
" this can cause some plugins problems (but fixes problems with tsuquyomi)
set shellslash

"let mapleader="\"

" EDITOR SETTINGS
set hidden
set nowrap
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set autoindent                  " carry indentation on newline
set copyindent                  " carry indentation on newline
set number                      " show line numbers
set showmatch                   " show matching parentheses
set matchtime=2                 " ms to show matching parens in showmatch
set hlsearch                    " highlight seach
set incsearch                   " search as you type
set history=1000                " large command history
set undolevels=1000             " large undo history
set undodir=~/.vim/undo         " persistent undo
set undofile
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
set laststatus=2
set textwidth=0                 " disable automatic word wrap
set showcmd                     " display incomplete commands
set cursorline                  " hilight current line
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set scrolloff=3                 " scroll before cursor is at edge of screen
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp,.
set wrap

" tab completion
set wildmenu                    " show a menu of completions
set wildmode=full               " complete longest common prefix first

" set default register to use system clipboard
set clipboard=unnamed

" remember buffers on reopen
set viminfo='100,<50,s10,h,rA:,rB:,%

" automatically add the current extension to 'gf' paths
autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')

" PLUGINS
let g:pathogen_disabled = ['vim-gitgutter', 'vim-easytags'] " vim-gitgutter: SLOW ON bn
" Load pathogen
execute pathogen#infect()

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
" disable syntastic on python by default
let g:syntastic_mode_map = {'passive_filetypes': ['python']}

" tsuquyomi settings
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:tsuquyomi_completion_detail = 1 "may cause slowdown
let g:tsuquyomi_shortest_import_path = 1
"temp bc it can't find vienna tsserver for some reason

" C++ SETTINGS
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -pedantic"

" HTML TIDY SETTINGS
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:syntastic_python_flake8_args="--ignoreE501"

" NERDTREE SETTINGS
"autostart nerdtree
"autocmd vimenter * NERDTree
" autocmd BufNew * wincmd 1
"autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd p | endif

" CTRL-P SETTINGS
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/](build|[.]git|node_modules|bower_components|dist|.sass-cache|Godeps)$',
\ 'file': '\v\.(DS_Store)$' }
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:ctrlp_max_files = 50000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_lazy_update = 100

" gitgutter options
let g:gitgutter_sign_column_always = 1

" BINDINGS
" use space as mapleader (silent off)
map <space> <leader>
map <space><space> <leader><leader>

" Map ctrl-movement keys to window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>

" don't exit visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

" toggle paste mode
set pastetoggle=<leader>p

" save
nnoremap <leader>w :w<cr>

" open file explorer
nnoremap <leader>F :NERDTreeToggle<cr>

" buffer bindings

nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap <leader>n :enew<cr>

" font size change bindings
"nnoremap + :silent! set guifont=Source_Code_Pro:h11:cANSI<CR>
"nnoremap = :silent! let &guifont = substitute(
 "\ &guifont,
 "\ ':h\zs\d\+',
 "\ '\=eval(submatch(0)+1)',
 "\ '')<CR>
"nnoremap - :silent! let &guifont = substitute(
 "\ &guifont,
 "\ ':h\zs\d\+',
 "\ '\=eval(submatch(0)-1)',
 "\ '')<CR>
" wrap word in quotes

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

imap <C-Space> <C-x><C-o>
imap <C-@> <C-x><C-o>

" bind 'make', automatically open the quickfix window
nnoremap <leader>b :call MakeAndShowErrors()<cr>

function! MakeAndShowErrors()
	make
	if v:shell_error
		copen
	endif
endfunction

" NERD Commenter bindings
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" easymotion bindings
nmap <leader>d <Plug>(easymotion-bd-w)
nmap <leader>s <Plug>(easymotion-s2)

" syntastic bindings
nnoremap <leader>[ :lprevious<cr>
nnoremap <leader>] :lnext<cr>

" undotree bindings
nnoremap <leader>u :UndotreeToggle<cr>

" git-gutter bindings (change <leader>h)
"nmap <leader>Hs <Plug>GitGutterStageHunk
"nmap <leader>Hr <Plug>GitGutterRevertHunk
"nmap <leader>Hp <Plug>GitGutterPreviewHunk

" reopen readonly file with sudo using ;w!!
cnoremap w!! w !sudo tee % >/dev/null

" MAKE COMMAND SETTINGS
autocmd FileType tex setlocal makeprg=texfot\ pdflatex\ --shell-escape\ -interaction=nonstopmode\ %

" TYPESCRIPT SPECIFIC COMMANDS
autocmd FileType typescript map <buffer> <leader>i :TsuImport<cr>

" toggle quickfix window
let g:jah_Quickfix_Win_Height=10

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen " . g:jah_Quickfix_Win_Height
  endif
endfunction

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

nnoremap <silent> <leader>f :QFix<cr>


" VISUAL SETTINGS
if &t_Co >= 256 || has("gui_running")
    colorscheme burgundy
    "set guifont=Lucida_Console:h11
    set guifont=Source_Code_Pro:h11:cANSI
    set guioptions-=T " remove toolbar
endif

" vertical line at 80 characters
set colorcolumn=81
"highlight ColorColumn guibg=#303030 ctermbg=235

" change cursorline color when in insert mode
"autocmd InsertEnter * hi CursorLine guibg=#2C3038 ctermbg=236 cterm=none
"autocmd InsertLeave * hi CursorLine guibg=#2d2d2d ctermbg=236 cterm=none

" Statusline settings

" change statusline color based on mode
"if version >= 700
  "au InsertEnter * hi StatusLine guifg=#7e8aa2 guibg=#2d2d2d gui=italic ctermfg=103 ctermbg=236 cterm=italic
  "au InsertLeave * hi StatusLine guifg=#e2e2e5 guibg=#444444 gui=italic ctermfg=253 ctermbg=238 cterm=italic
"endif

"green = 148
"orange = 208
"blue = 103
"very light grey = 253
"darker grey = 238
"dark grey = 234

"hi User2 guifg=#2d2d2d guibg=#ff9800 gui=bold ctermfg=236 ctermbg=208 cterm=bold
"hi User3 guifg=#2d2d2d guibg=#7e8aa2 gui=none ctermfg=236 ctermbg=103
"hi User7 guifg=#2d2d2d guibg=#e2e2e5 gui=bold ctermfg=236 ctermbg=253 cterm=bold
"hi User4 guifg=#2d2d2d guibg=#7e8aa2 gui=bold ctermfg=236 ctermbg=103 cterm=bold

set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%2*\%m%r%w                           " modified/readonly
set statusline+=%3*\ %<%F\                                "File+path
set statusline+=%*\ %y\                                  "FileType
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=col:%03c\                            "Colnr
set statusline+=%P\ \                      "Modified? Readonly? Top/bot.

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>. :call SynStack()<cr>

