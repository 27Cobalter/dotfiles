" キーマップ
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
noremap <silent> <C-c> <C-c>:call SetIME('off')<CR>
inoremap <silent> <C-c> <C-c>:call SetIME('off')<CR>

noremap <Leader>ll <ESC><ESC>:call aload#Run()<CR>

noremap <Leader>lf <ESC><ESC>:call aload#Format()<CR>

nnoremap <Leader>sn :next<CR>
nnoremap <Leader>sp :prev<CR>

noremap <A-p> gt<CR>
noremap <A-n> gT<CR>
noremap <A-o> :tabonly<CR>
noremap <A-t><CR> :tabedit<CR>:Startify<CR>

tnoremap <C-w> <C-\><C-n><C-w>

noremap <Leader>st :new<CR>:terminal<CR>:startinsert<CR>

noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-+> <C-w>+
noremap <A--> <C-w>-
noremap <A-,> <C-w><
noremap <A-.> <C-w>>

noremap <C-]> g<C-]>

tnoremap <ESC> <C-\><C-n>

nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)
