" いま開いているファイルを指定フォーマットになおす
function! aload#Format()
  w
  let l:ft=&filetype
  if l:ft=="cpp"||l:ft =="c"||l:ft=="java"||l:ft=="arduino"
    call system('clang-format -i '.expand("%:p"))
    e!
    echo "Format succes"
  elseif l:ft=="go"
    GoFmt
    echo "Format succes"
  elseif l:ft=="python"
    call system('black '.expand("%:p"))
    e!
    echo "Format succes"
  else
    echo 'Not support filetype '.l:ft
  endif
endfunction
" いま開いているファイルがcppだった場合コンパイルして実行
function! aload#Run()
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
    InstantMarkdownPreview
  elseif l:ft=="plantuml"
    let l:mes = system('plantuml '.expand("%:p"))
    echo "execute plantuml ".l:mes
  elseif l:ft=="tex"
    call Tex_RunLaTeX()
  else
    QuickRun
  endif
endfunction
" TlistとSrcExplのコマンドをまとめた関数
function! aload#CT()
  Tlist
  SrcExpl
endfunction
" 縦にタブ分割をしてterminalを起動
function! aload#Vterminal()
    vs
    terminal
endfunction
" 横にタブ分割をしてterminalを起動
function! aload#Sterminal()
    sp
    terminal
endfunction
" タブを生成してterminal
function! aload#Terminal()
  tabe
  terminal
endfunction

function! aload#Sc()
  let g:syntaxCheck=1
endfunction
function! aload#Nsc()
  let g:syntaxCheck=0
endfunction
