runtime bundle/vim-pathogen/autoload/pathogen.vim

filetype plugin indent on
syntax on
set backspace=indent,eol,start

set nocompatible

execute pathogen#infect()

"let mapleader="\"

" EDITOR SETTINGS
set hidden
set nowrap
set shiftwidth=4
set tabstop=4
set copyindent " carry indentation on newline
set number     " show line numbers
set showmatch  " show matching parentheses
set hlsearch   " highlight seach
set incsearch  " search as you type
set history=1000 " large command history
set undolevels=1000 " large undo history
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set laststatus=2
set textwidth=0 " disable automatic word wrap

" OMNICOMPLETE SETTINGS
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

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

" clear search highlight with ,/
nnoremap <silent> ,/ :nohlsearch<CR>

" save
nnoremap <leader>w :w<cr>

" buffer bindings

nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap <leader>n :enew<cr>

" wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" omnicomplete bindings
" automatically select first omnicomplete option
inoremap <expr> <C-x><C-o> pumvisible() ? '<C-x><C-o>' :
  \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

imap <C-Space> <C-x><C-o>
imap <C-@> <C-x><C-o>

" NERD Commenter bindings
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" easymotion bindings
nmap <leader>d <Plug>(easymotion-bd-w)
nmap <leader>s <Plug>(easymotion-s2)

" syntastic bindings
nnoremap <leader>[ :lprevious<cr>
nnoremap <leader>] :lnext<cr>

" reopen readonly file with sudo using ;w!!
cnoremap w!! w !sudo tee % >/dev/null

" SYNTASTIC SETTINGS
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" C++ SETTINGS
let g:syntastic_cpp_compiler_options = "-Wall -Wextra -pedantic"

" HTML TINY SETTINGS
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" NERDTREE SETTINGS
"autostart nerdtree
autocmd vimenter * NERDTree
" autocmd BufNew * wincmd 1
autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd p | endif

" VISUAL SETTINGS
if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

" vertical line at 80 characters
set colorcolumn=81
highlight ColorColumn ctermbg=235

" Statusline settings

" change statusline color based on mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=103 ctermbg=236 cterm=italic
  au InsertLeave * hi StatusLine ctermfg=253 ctermbg=238 cterm=italic
endif

"green = 148
"orange = 208
"blue = 103
"very light grey = 253
"darker grey = 238
"dark grey = 234
hi User2 ctermfg=236 ctermbg=208 cterm=bold
hi User3 ctermfg=236 ctermbg=103
hi User7 ctermfg=236 ctermbg=253 cterm=bold
hi User4 ctermfg=236 ctermbg=103 cterm=bold

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

