#!/bin/zsh
# zplugの設定
TERM=xterm-256color

if [ ! -e ~/.zplug ]; then
  printf 'install zplug? [y/N]: '
  if read -q; then
    git clone https://github.com/zplug/zplug ~/.zplug
  fi
fi

source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
if ! zplug check --verbose; then
  printf 'install zplug_plugins? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose > /dev/null 2>&1

# zsh-syntax-highlightingの色設定
ZSH_HIGHLIGHT_STYLES[alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=red,underline
ZSH_HIGHLIGHT_STYLES[function]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan

# zsh設定
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt auto_list
setopt auto_menu
setopt inc_append_history
setopt magic_equal_subst
setopt EXTENDED_HISTORY
setopt hist_ignore_all_dups

zmodload zsh/zpty
setopt auto_pushd
setopt auto_cd
setopt correct
setopt list_packed
setopt no_beep
setopt prompt_subst

bindkey "^[[Z" reverse-menu-complete
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

export FZF_DEFAULT_OPTS='
--color fg:-1,bg:-1,hl:202,fg+:214,bg+:52,hl+:231
--color info:52,prompt:196,spinner:208,pointer:196,marker:208
'

# エイリアス
alias ls="ls --color=auto -F"
alias la="ls --color=auto -Fa"
alias ll="ls --color=auto -Fl"
alias lla="ls --color=auto -Fla"
alias grep="grep --color"

if which trash-put &>/dev/null; then
  alias rm=trash-put
fi

# percolでhistory検索
function percol-select-history(){
  BUFFER=$(\history -n 1 | tac | awk '!a[$0]++' | percol --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N percol-select-history
bindkey '^r' percol-select-history

# fzfでhistory検索
function fzf-select-history(){
  BUFFER=$(\history -n 1 | tac | awk '!a[$0]++' | fzf --reverse --height 50% --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N fzf-select-history
# ESC R
bindkey '^[r' fzf-select-history

# percolでkill
function percol-kill(){
  ps -aux | percol | awk '{ print "kill ", $2 }' | sh | cat /dev/stdin
}
# fzfでkill
function fzf-kill(){
  ps -aux | fzf --reverse --height 50% | awk '{ print "kill ", $2 }' | sh | cat /dev/stdin
}

# percolでtmuxのセッションを選択
if [[ ! -n "$TMUX" ]]; then
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    exec tmux new-session
  fi
  create_new_session="Create New Session"
  ID="${create_new_session}:\n${ID}"
  ID="`echo $ID | percol | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    exec tmux new-session
  elif [[ -n "$ID" ]]; then
    exec tmux attach-session -t $ID
  fi
fi
