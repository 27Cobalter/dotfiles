" いま開いているファイルを指定フォーマットになおす
function! myfunction#Format()
  w
  let l:ft=&filetype
  if l:ft=="cpp"||l:ft =="c"||l:ft=="java"||l:ft=="arduino"
    call system('clang-format -i '.expand("%:p"))
    e!
  elseif l:ft=="go"
    GoFmt
  else
    echo 'Not support filetype '.l:ft
  endif
endfunction
" いま開いているファイルがcppだった場合コンパイルして実行
function! myfunction#Run()
  w
  let l:ft=&filetype
  if l:ft=="cpp"
    let l:mes  = system("clang++ -g -std=c++17 ".expand("%:p")." $(pkg-config --cflags eigen3)")
    if l:mes==""
      !./a.out
    else
      echo l:mes
    endif
  elseif l:ft=="c"
    let l:mes  = system("gcc ".expand("%:p"))
    if l:mes==""
      !./a.out
    else
      echo l:mes
    endif
  elseif l:ft=="python"
    let l:mes = system("python3 ".expand("%:p"))
    echo l:mes
  elseif l:ft=="go"
    GoRun
  elseif l:ft=="arduino"
    sp
    terminal sudo platformio run --target=upload
  elseif l:ft=="markdown"
    MdPreview
  else
    QuickRun
  endif
endfunction
" TlistとSrcExplのコマンドをまとめた関数
function! myfunction#CT()
  Tlist
  SrcExpl
endfunction
" 縦にタブ分割をしてterminalを起動
function! myfunction#Vterminal()
    vs
    terminal
endfunction
" 横にタブ分割をしてterminalを起動
function! myfunction#Sterminal()
    sp
    terminal
endfunction
" タブを生成してterminal
function! myfunction#Terminal()
  tabe
  terminal
endfunction

function! myfunction#Sc()
  let g:syntaxCheck=1
endfunction
function! myfunction#Nsc()
  let g:syntaxCheck=0
endfunction
