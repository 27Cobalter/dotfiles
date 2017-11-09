#!/bin/zsh
# zplugの設定
TERM=xterm-256color

if [ ! -e ~/.zplug ]; then
  printf 'install zplug? [y/N]: '
  if read -q; then
    git clone https://github.com/zplug/zplug .zplug
  fi
fi

source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'
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

# PATHの設定
export AI=~/ai-server
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.gem/ruby/2.4.0/bin
export PATH=$PATH:/opt/cuda/bin
export BROWSER=/usr/bin/vivaldi-stable

# zsh設定
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt auto_list
setopt auto_menu
setopt inc_append_history
setopt magic_equal_subst
setopt EXTENDED_HISTORY
# setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
autoload -Uz compinit compinit -u promptinit
compinit
setopt auto_pushd
setopt auto_cd
setopt correct
setopt list_packed
setopt no_beep
promptinit
prompt="%F{white}[%f$USER%F{red}@%f%F{magenta}$HOST%f %1~%F{white}]%f%# "

bindkey "^[[Z" reverse-menu-complete
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# pecoの設定
function peco-select-history(){
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

[[ -s /home/ia/.autojump/etc/profile.d/autojump.sh ]] && source /home/ia/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# エイリアス
alias ls="ls --color=auto -F"
alias la="ls --color=auto -Fa"
alias ll="ls --color=auto -Fl"
alias lla="ls --color=auto -Fla"
alias grep="grep --color"
alias chromium="chromium > /dev/null 2>&1&"
alias libreoffice="libreoffice > /dev/null 2>&1&"
if which trash-put &>/dev/null; then
  alias rm=trash-put
fi
function arduino (){platformio $@ && ln -s /home/ia/arduino/.piolibdeps .piolibdeps && echo "upload_port = /dev/ttyACM0" >> platformio.ini && echo "#include<ArduinoSTL.h>\n\nvoid setup(){\n  // put your setup code here, to run once:\n}\nvoid loop(){\n  // put your main code here, to run repeatedly:\n}" > src/main.ino}

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
