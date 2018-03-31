" キーマップ
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
noremap <silent> <C-c> <C-c>:call ToggleIbusEngine('x')<CR>
cnoremap <silent> <C-c> <C-c>:call ToggleIbusEngine('x')<CR>
inoremap <silent> <C-c> <C-c>:call ToggleIbusEngine('x')<CR>

noremap <C-l> <ESC><ESC>:call myfunction#Run()<CR>
noremap! <C-l> <ESC><ESC>:call myfunction#Run()<CR>

noremap <C-s> <ESC><ESC>:call myfunction#Format()<CR>
noremap! <C-s> <ESC><ESC>:call myfunction#Format()<CR>

noremap <A-o> :on<CR>

noremap <A-p> gt<CR>
noremap <A-n> gT<CR>
noremap <A-o> :tabonly<CR>
noremap <A-t><CR> :tabedit<CR>:Startify<CR>

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)

noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-+> <C-w>+
noremap <A--> <C-w>-
noremap <A-,> <C-w><
noremap <A-.> <C-w>>

noremap <C-]> g<C-]>

noremap <silent> gb :Denite buffer<CR>

inoremap <expr> = smartchr#loop(' = ',' == ', '=')

inoremap <expr> , smartchr#loop(', ',',')

tnoremap <ESC> <C-\><C-n>
