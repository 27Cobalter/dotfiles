" vimの設定"{{{
set fenc=utf-8
" vi互換の動作を無効にするコマンド
set nocompatible
" インデント
filetype indent on
" これやらないとcaw.vimが動かない
filetype plugin on
" バックスペースは行末は消去不可
set bs=indent,eol,start
" 履歴情報を保存するviminfoを作成
set viminfo='20,\"50
" コマンドの履歴数を50に設定
set history=50
" 保存されていないファイルがあるときは終了前に保存確認
set confirm
" 保存されていないファイルがある時でも別ファイルを開けるようにする
set hidden
" 入力中のコマンドを表示
set showcmd
" 行を表示
set number
" カーソルラインを表示
set cursorline
" 括弧をハイライト
set showmatch
" 折り畳み
set foldmethod=marker
" ステータス表示とか
set laststatus=2
set statusline=%<%f
set statusline+=\ %m
set statusline+=[%{&fileencoding}:%{&ff}]%y
set statusline+=%=
set statusline+=%c,%l\ /%L\ %p%%
" 検索結果をハイライト
set hlsearch
" 不可視文字の表示と設定
set list
set listchars=tab:>-,eol:$,trail:-
" tab設定
set shiftwidth=4
set tabstop=4
" インクリメンタルサーチ
set incsearch
" 行末まで検索したら先頭に戻る
set wrapscan
" インデント
set autoindent
" 上下1行の視界を確保
set scrolloff=1
" マウス無効
set mouse-=a

" 前回の編集場所から開始できる(rootのvimrcからパクってきたからよくわからん)
if has("autocmd")
  augroup nyan
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

" cscopeっていう凄いものの設定(/etc/vimrcからのパクり)
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   if filereadable("cscope.out")
      cs add $pwd/cscope.out
   elseif $cscope_db != ""
      cs add $cscope_db
   endif
   set csverb
endif
" }}}

" プラグインマネージャ"{{{
" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#add("wesleyche/SrcExpl",{
              \"autoload":{"commands":["SrcExplToggle"]}})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" }}}

" 自作関数宣言{{{
" いま開いているファイルを指定フォーマットになおす
function! Format()
  w
  if &filetype=="cpp"
    call system('clang-format -i '.expand("%:p"))
    e!
  elseif &filetype=="c"
    call system('clang-format -i '.expand("%:p"))
    e!
  elseif &filetype=="go"
    GoFmt
  elseif &filetype=="arduino"
    call system('clang-format -i '.expand("%:p"))
    e!
  else
    echo 'Not support filetype '.&filetype
  endif

endfunction
" いま開いているファイルがcppだった場合コンパイルして実行
function! Run()
  w
  let l:ft=&filetype
  if l:ft=="cpp"
    let l:mes  = system("clang++ -std=c++14 ".expand("%:p")." $(pkg-config --cflags eigen3)")
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
    !sudo platformio run --target=upload
  elseif l:ft=="markdown"
    MdPreview
  else
    QuickRun
  endif
endfunction

" IMEを切り換える関数
function ToggleIbusEngine(mode)
  if a:mode=='x'
      call system('ibus engine "xkb:jp::jpn"')
  elseif a:mode=='k'
      call system('ibus engine "kkc"')
  else
    if split(system('ibus engine'))[0]=="kkc"
      call system('ibus engine "xkb:jp::jpn"')
    else
      call system('ibus engine "kkc"')
    endif
  endif
endfunction

" 縦にタブ分割をしてVimShellを起動
function! VS()
  vs
  VimShell
endfunction
" 横にタブ分割をしてVimShellを起動
function! SP()
  sp
  VimShell
endfunction
" TlistとSrcExplのコマンドをまとめた関数
function! CT()
  Tlist
  SrcExpl
endfunction
" }}}

" コマンド宣言{{{
command Run call Run()
command VS call VS()
command SP call SP()
command CT call CT()
" }}}

" プラグインに関する設定{{{
set t_Co=256
syntax on
colorscheme jellybeans
" VimShellのプロンプトの設定
function! PWD()
  if $PWD == $HOME
    let l:cudir='~'
  else
    let l:cudir=split(system("basename $PWD"))[0]
  endif
  return l:cudir
endfunction
let g:vimshell_prompt_expr='"[".split(system("echo $USER"))[0]."@".split(system("hostname"))[0]." ".PWD(). "]$ "'
let g:vimshell_prompt_pattern='\[.*\]$ '

let tlist_php_settings='php;c:class;d:constant;f:function'

let token="token"
let g:mastodon_host='yukari.cloud'
" let g:mastodon_access_token='mastodon_token'

au BufRead,BufNewFile *.md set filetype=markdown
" let g:previm_open_cmd='chromium'

if filereadable(expand('token.vim'))
  source token.vim
endif

" }}}

" キー設定{{{
" 自作関数のマッピングとか
noremap <silent> <C-c> <ESC><ESC>:call ToggleIbusEngine('x')<CR>
cnoremap <silent> <C-c> <ESC><ESC>:call ToggleIbusEngine('x')<CR>
inoremap <silent> <C-c> <ESC><ESC>:call ToggleIbusEngine('x')<CR>

noremap <silent> <C-k> :call ToggleIbusEngine('t')<CR>
cnoremap <silent> <C-k> :call ToggleIbusEngine('t')<CR>
inoremap <silent> <C-k> <C-o>:call ToggleIbusEngine('t')<CR>

noremap <C-l> <ESC><ESC>:call Run()<CR>
noremap! <C-l> <ESC><ESC>:call Run()<CR>

noremap <C-s> <ESC><ESC>:call Format()<CR>
noremap! <C-s> <ESC><ESC>:call Format()<CR>

noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-;> <C-w>+
noremap <A--> <C-w>-
noremap <A-,> <C-w><
noremap <A-.> <C-w>>
inoremap <expr> = smartchr#loop(' = ',' == ', '=', ' := ')
inoremap <expr> , smartchr#loop(', ',',')
" }}}
