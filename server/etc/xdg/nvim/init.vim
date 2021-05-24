" format json
nnoremap <leader>fj :%! python -m json.tool<CR>
vnoremap <leader>fj :! python -m json.tool<CR>

" convert (format) to hex
nnoremap <expr> <leader>fh :%!od -A x -t x1z -v<CR>
" Editor Settings {{{
set hidden
set shiftwidth=4
set tabstop=4
set softtabstop=-4
set copyindent                  " carry indentation on newline
set incsearch                   " search as you type
set ignorecase                  " ignore case in search
set smartcase                   " case sensitive when using capital letters
set textwidth=0                 " disable automatic word wrap
set completeopt+=noinsert       " auto-select first omnicomplete result
set mouse=a                     " enable mouse
" }}}
set clipboard+=unnamedplus
set foldlevelstart=2

" focus the current line (close all folds except this one, then center the
" screen)
nnoremap <leader>z zMzvzz

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
	if len(l:line) < l:minwidth
		let l:line = l:line . repeat(' ',(l:minwidth)-len(l:line))
	endif
    let l:line = strpart(l:line, 0, l:windowwidth - len(l:rightcoltext)-2)

	return l:line . repeat(' ', l:fillcharcount) . l:rightcoltext
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
set statusline+=%#Todo#%m%r%w%*                           " modified/readonly
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
	autocmd FileType css,sass,scss execute 'setl iskeyword+=-'
	" skip quickfix list on :bn
	autocmd FileType qf set nobuflisted
	" use spaces instead of tabs in certain filetypes
	autocmd FileType typescript execute 'setl expandtab'
	autocmd FileType typescript execute 'setl expandtab'
	autocmd BufEnter * call RemoveBufferIfPreview()
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
