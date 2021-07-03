nmap <C-C> :quitall!<CR>
nmap b <PageUp>
vmap b <PageUp>

set ignorecase
set smartcase

set clipboard+=unnamedplus

nnoremap <silent>, :nohlsearch<CR>

function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap . :call SynStack()<cr>

let g:polyglot_disabled = ['typescript', 'csv']

call plug#begin('~/.local/share/nvim/plugged')

Plug 'elliothatch/burgundy.vim'
Plug 'chrisbra/Colorizer'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'sheerun/vim-polyglot'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mustache/vim-mustache-handlebars'

call plug#end()

set termguicolors
colorscheme burgundy


hi DiffAdded guifg=#8bf792 guibg=#1a0a16 guisp=#0a4a19 gui=NONE ctermfg=120 ctermbg=234 cterm=NONE
hi DiffRemoved guifg=#d11b2d guibg=#1a0a16 guisp=#630512 gui=NONE ctermfg=160 ctermbg=234 cterm=NONE
hi diffFile guifg=#f0bf69 guibg=NONE guisp=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE

let g:colorizer_auto_filetype='css,html,scss,sass'

