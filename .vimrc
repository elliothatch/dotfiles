runtime bundle/vim-pathogen/autoload/pathogen.vim

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

" BINDINGS
" use space as mapleader (silent off)
map <space> <leader>
map <space><space> <leader><leader>
" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" don't exit visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" clear search highlight with ,/
nmap <silent> ,/ :nohlsearch<CR>

" save
nmap <leader>w :w<cr>

" buffer bindings

nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>
nmap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
nmap <leader>n :enew<cr>

" easymotion bindings
nmap <leader>s <Plug>(easymotion-bd-w)
nmap <leader>d <Plug>(easymotion-sn)

" syntastic bindins
nmap <leader>[ :lprevious<cr>
nmap <leader>] :lnext<cr>

" reopen readonly file with sudo using ;w!!
cmap w!! w !sudo tee % >/dev/null

"LINT SETTINGS
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

