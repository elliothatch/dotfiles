" remember buffers on reopen
set viminfo='100,<50,s10,h,rA:,rB:,%

" disable syntastic on python by default
let g:syntastic_mode_map = {'passive_filetypes': ['python']}
let g:syntastic_python_flake8_args="--ignoreE501"
