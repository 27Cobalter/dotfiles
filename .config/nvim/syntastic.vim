let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = {'mode': 'passive'} 
augroup AutoSyntastic
    autocmd!
    autocmd InsertLeave,TextChanged * call g:Syntastic() 
augroup END

function! g:Syntastic()
  if g:syntaxCheck==1
    w
    SyntasticCheck
    call lightline#update()
  endif
endfunction
