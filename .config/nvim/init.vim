" vimの設定"{{{
set modifiable
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
set shiftwidth=2
set tabstop=2
set expandtab
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
" 文字列置換をインタラクティブに
set inccommand=split
" プレビューをいれない
set completeopt=menuone
" clipboard
set clipboard&
set clipboard^=unnamedplus

set ambiwidth=double

let mapleader="\<Space>"

" jsonの""やtexの$E$, mc^2をそのまま表示する
" プレビューしたい場合は2に設定する
set conceallevel=0
"スペルチェック
" set spell
"
let g:python3_host_prog = '/bin/python3'
let g:python_host_prog = '~/.pyenv/shims/python2'

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
let g:other_package_path = expand('~/.cache/dein/package')
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
  call dein#add('Shougo/deoppet.nvim')
  " 設定終了
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" }}}

" 自作関数宣言{{{
" IMEを切り換える関数
function SetIME(mode)
  if a:mode=='off'
    call system('fcitx-remote -c')
  else
    call system('fcitx-remote -o')
  endif
endfunction
" }}}

" コマンド宣言{{{
command Run call aload#Run()
command CT call aload#CT()
command VT call aload#Vterminal()
command ST call aload#Sterminal()
command Terminal call aload#Terminal()
command Sc call aload#Sc()
command Nsc call aload#Nsc()
" }}}

" autocmdとか{{{
" 前回の編集場所から開始
augroup nyan
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
augroup END

" インサートモードを離れたときにIMEをオフにする
" augroup IMEGroup
"   autocmd!
  autocmd InsertLeave * :call SetIME('off')
" augroup END

if has('nvim')
" Terminalのときは行番号とスペルチェックをなしにする
  autocmd TermOpen * set nonumber
  autocmd TermClose * set number
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
endif
" }}}

" プラグインに関する設定{{{
set t_Co=256
syntax on
colorscheme jellybeans

let tlist_php_settings='php;c:class;d:constant;f:function'

if filereadable(expand('~/.config/nvim/token.vim'))
  source ~/.config/nvim/token.vim
endif

let twitvim_enable_python3 = 1

let g:syntaxCheck=0

call gina#custom#command#alias('status', 'st')
call gina#custom#command#option('st','-s')
call gina#custom#command#option('st','--opener','split')
" }}}
