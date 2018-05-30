" Setup {{{
set shellslash

" python support setup
let g:python3_host_prog='C:/Users/ellio/.local/virtualenvs/neovim3/Scripts/python.exe'
let g:python_host_prog='C:/Users/ellio/.local/virtualenvs/neovim2/Scripts/python.exe'
" }}}
" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'

" editor
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'tag': '4.0-serial' }
Plug 'kshenoy/vim-signature'

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

" uses ctags (https://github.com/universal-ctags/ctags)
"Plug 'majutsushi/tagbar'

Plug 'chrisbra/Colorizer'

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" syntax
"Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
"Plug 'mxw/vim-jsx'
"Plug 'leafgarland/typescript-vim'
"Plug 'rust-lang/rust.vim'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mustache/vim-mustache-handlebars'

" typescript
"Plug 'mhartington/nvim-typescript', {'commit': 'b1d61b22d2459f1f62ab256f564b52d05626440a'}
Plug 'elliothatch/nvim-typescript' " slightly modified old version that works on windows

" nyaovim
Plug 'rhysd/nyaovim-markdown-preview'

"Plug 'D:/workspace/nyaovim-color-picker'

call plug#end()
" }}}
"  - Options {{{
" vim-airline/vim-airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='luna'
"
"let g:airline_powerline_fonts = 1
"let g:airline_extensions = ['tabline']

" neomake/neomake
let g:neomake_open_list = 2

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" elliothatch/nvim-typescript
let g:nvim_typescript#_server_path = 'node_modules\\.bin\\tsserver'

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
call neomake#configure#automake('rw', 1000)
" }}}
"  - Bindings {{{
" scrooloose/nerdcommenter
nmap <leader>/ <leader>c<Space>
vmap <leader>/ <leader>c<Space>

" scrooloose/nerdtree
"" open file explorer
nnoremap <leader>d :NERDTreeToggle<cr>

" mbbill/undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Shougo/denite.nvim
nnoremap <C-p> :<C-u>Denite file_rec/git<CR>
nnoremap <C-Space> :<C-u>Denite buffer<CR>

" tpope/vim-fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gU :Gread<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" mileszs/ack.vim
"vnoremap <Leader>av :<C-u>let cmd = "Ack! " . VAck() <bar> call histadd("cmd", cmd) <bar> execute cmd<CR>

"nnoremap <expr> <leader>ss ':Ack! '          . input('[ack]: ')              . ' ' . expand('%:p:h') . '<cr>'
nnoremap <expr> <leader>ss InputOrCancel('Ack! ',    '[ack]: ',     '') . '<cr>'
nnoremap <expr> <leader>sl InputOrCancel('LAck ',    '[ack]\|L: '), '') . '<cr>'
nnoremap <expr> <leader>sf InputOrCancel('AckFile ', '[ack]\|F: '), '') . '<cr>'
nnoremap <expr> <leader>s/ 'AckFromSearch ' . '<cr>'

" search from current buffer path
nnoremap <expr> <leader>Ss InputOrCancel('Ack! ',    '[ack\|b]: ',    ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>Sl InputOrCancel('LAck ',    '[ack\|b]\|L: ', ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>Sf InputOrCancel('AckFile ', '[ack\|b]\|F: ', ' ' . expand('%:p:h')) . '<cr>'
nnoremap <expr> <leader>S/ 'AckFromSearch ' . expand('%:p:h') . '<cr>'


" elliothatch/nvim-typescript

nnoremap <leader>td :TSDef<CR>
nnoremap <leader>tD :TSTypeDef<CR>
nnoremap <leader>ti :TSImport<CR>
nnoremap <leader>tm :TSDoc<CR>
nnoremap <leader>ts :TSTypePreview<CR>

" }}}
" Editor Settings {{{
set hidden
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set copyindent                  " carry indentation on newline
set clipboard+=unnamed
set incsearch                   " search as you type
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set undofile                    " save undo history to file
set textwidth=0                 " disable automatic word wrap
set completeopt+=noinsert       " auto-select first omnicomplete result
set mouse=a                     " enable mouse
" }}}
"  - Folding {{{

set foldlevelstart=0

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
	let l:fillcharcount = l:windowwidth - len(l:line) - len(l:rightcoltext)-2
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
set termguicolors

set inccommand=split " live substitution with search matches shown in split
colorscheme burgundy

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
" }}}
" Autocommands {{{
augroup myautocmds
	" automatically add the current extension to 'gf' paths
	autocmd!
	autocmd BufNewFile,BufRead * execute 'setl suffixesadd+=.' . expand('%:e')
	" make  '-' part of words in css files
	autocmd FileType css,sass execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted
	" use spaces instead of tabs in certain filetypes
	autocmd FileType typescript execute 'setl expandtab'
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
" Bindings {{{
map <space> <leader>
map <space><space> <leader><leader>

"map \ <leader>
"map \\ <localleader><localleader>

nnoremap <leader>w :w<cr>
map <tab> %

" clear search highlight
nnoremap <silent> <leader>, :nohlsearch<CR>

" }}}
"  - Buffers {{{
let g:bpLast = 0
function! SetBpLast(bp, result)
	let g:bpLast = a:bp
	return a:result
endfunction
nnoremap <expr> <leader>l SetBpLast(0, ":bnext\<cr>")
nnoremap <expr> <leader>h SetBpLast(1, ":bprevious\<cr>")
" close buffer without closing split (switch to next buffer, delete prev buffer offscreen. if the last buffer swtich was :bn, call :bp. if this is the last buffer just close it
nnoremap <expr> <leader>q len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? (g:bpLast == 0 ? ":bn\<bar>bd#\<bar>bp\<cr>" : ":bn\<bar>bd#\<cr>") : ":bd\<cr>"
nnoremap <leader>n :enew<cr>

" }}}
"  - Navigation {{{
" visual cursor movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"
" Keep search matches in the middle of the window.
"nnoremap n nzzzv
"nnoremap N Nzzzv

" Easier to type, and I never use the default behavior.
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
nnoremap <leader>Q :q<cr>

" split
noremap <leader>v <C-w>v

" Map ctrl-movement keys to window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>
"}}}
"  - Quickfix List {{{
nnoremap <leader>fo :copen<cr>
nnoremap <leader>fc :cclose<cr>
nnoremap <leader>fl :cnext<cr>
nnoremap <leader>fh :cprevious<cr>

" location list
nnoremap <leader>Fo :lopen<cr>
nnoremap <leader>Fc :lclose<cr>
nnoremap <leader>Fl :lnext<cr>
nnoremap <leader>Fh :lprevious<cr>

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
" esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

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

"call AutocompleteOnInsertChar([
"\'(', ')', '[', ']',
"\';', ',', '.',  ':',
"\'!', '='])
"
" }}}
