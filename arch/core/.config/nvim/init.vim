" Setup {{{
set shellslash

let g:HomeDir='/home/ellioth/'
" python support setup
let g:python3_host_prog=g:HomeDir . '.local/virtualenvs/neovim3/bin/python'
let g:python_host_prog=g:HomeDir . '.local/virtualenvs/neovim2/bin/python'
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
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-commentary'

" coc extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}

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

" uses ctags (https://github.com/universal-ctags/ctags)
"Plug 'majutsushi/tagbar'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'chrisbra/Colorizer'

Plug 'mbbill/undotree'

" syntax
"Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
"Plug 'mxw/vim-jsx'
" Plug 'leafgarland/typescript-vim'
"Plug 'rust-lang/rust.vim'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'mustache/vim-mustache-handlebars'

" tags
" Plug 'c0r73x/neotags.nvim', {'do': 'make'}
Plug 'liuchengxu/vista.vim'

" typescript
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"Plug 'mhartington/nvim-typescript', {'commit': 'b1d61b22d2459f1f62ab256f564b52d05626440a'}
" Plug 'elliothatch/nvim-typescript' " slightly modified old version that works on windows

" c
Plug 'vim-scripts/headerguard'

" nyaovim
" Plug 'rhysd/nyaovim-markdown-preview'

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> <leader>tm :call <SID>show_documentation()<CR>
nmap <silent> <leader>tr <Plug>(coc-references)
nmap <silent> <leader>tR <Plug>(coc-rename)
nmap <silent> <leader>td <Plug>(coc-definition)
nmap <silent> <leader>tD <Plug>(coc-type-definition)
nmap <silent> <leader>ti <Plug>(coc-implementation)
nmap <silent> <leader>t[ <Plug>(coc-diagnostic-next)
nmap <silent> <leader>t] <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>t/ :CocList outline<CR>
nmap <silent> <leader>te :CocList diagnostics<CR>

" nnoremap <leader>tt :TSType<CR>
" nnoremap <leader>ti :TSImport<CR>
" nnoremap <leader>ts :TSTypePreview<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" liuchengxu/vista
let g:vista_default_executive = 'coc'
" let g:vista_executive_for = {
" \ 'c': 'ctags',
" \ 'cpp': 'ctags',
" \}

nnoremap <leader>to :Vista!!<cr>
nnoremap <leader>tf :Vista finder<cr>


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
call neomake#configure#automake('rw', 1000)
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

" mileszs/ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column --hidden --path-to-ignore ' . g:HomeDir . '.config/ag/.ignore'
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
set completeopt+=noinsert       " auto-select first omnicomplete result
set mouse=a                     " enable mouse
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
set statusline+=%{SpinnerText()}\      "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}            "Encoding2
set statusline+=[%{&ff}]\                              "FileFormat (dos/unix..)
set statusline+=%y\                                  "FileType
set statusline+=0x%04B\          "character under cursor
set statusline+=%l:%v\  "row:col
set statusline+=%p%%\  "row %
"set statusline+=%P\ \                      "Modified? Readonly? Top/bot.
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
	" don't add preview window buffers to buffer list
	autocmd BufEnter * call RemoveBufferIfPreview()
	" autocmd BufReadPre * call PreReadIncludes()
	" autocmd BufEnter c,cpp call LoadIncludes()
	" autocmd FileType c,cpp set makeprg=BATCH_BUILD=1\ make
	
	autocmd FileType c,cpp execute 'setl makeprg=idf.py\ build'
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
nnoremap <leader>d :diffthis<cr>
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
