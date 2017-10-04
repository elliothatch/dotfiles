set shellslash

" python support setup
let g:python3_host_prog='C:/Users/ellio/.local/virtualenvs/neovim3/Scripts/python.exe'
let g:python_host_prog='C:/Users/ellio/.local/virtualenvs/neovim2/Scripts/python.exe'

" PLUGIN SETUP
" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

" neomake/neomake
let g:neomake_open_list = 2

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" load plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'

" editor
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kshenoy/vim-signature'

" visual
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" nyaovim
Plug 'rhysd/nyaovim-markdown-preview'

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
set cursorline                  " hilight current line
set scrolloff=3                 " scroll before cursor is at edge of screen
set colorcolumn=81
" set termguicolors

" AUTOCMDS
" automatically add the current extension to 'gf' paths
autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')

" BINDINGS
" use space as mapleader (silent off)
map <space> <leader>
map <space><space> <leader><leader>

" NORMAL MODE
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

" open file explorer
nnoremap <leader>F :NERDTreeToggle<cr>

" buffer bindings
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap <leader>n :enew<cr>

" wrap word in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" VISUAL MODE
" don't exit visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" TERMINAL MODE
" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" PLUGIN BINDINGS
" scrooloose/nerdcommenter
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" scrooloose/nerdtree
"" open file explorer
nnoremap <leader>F :NERDTreeToggle<cr>

" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Shougo/denite.nvim
nnoremap <C-p> :<C-u>Denite file_rec/git<CR>
nnoremap <C-Space> :<C-u>Denite buffer<CR>

" PLUGIN SETUP
"
" Shougo/denite.nvim
" add git ls-files source
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

" move cursor up/down with Ctrl-j and Ctrl-k
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" neomake/neomake
" automatically run on load and save
autocmd! BufWritePost,BufEnter * Neomake

" VISUAL SETTINGS
colorscheme mustang
