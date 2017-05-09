# 幸せになれるもの
/usr/bin/vmware-user-suid-wrapper
sh /home/ia/.fehbg

# zplugの設定
source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'
if ! zplug check --verbose; then
  printf 'install? [y/N]: '
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
ZSH_HIGHLIGHT_STYLES[function]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan

# PATHの設定
export AI=/home/ia/ai-server
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# zsh設定
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt auto_list
setopt auto_menu
setopt inc_append_history
setopt magic_equal_subst
setopt share_history
setopt EXTENDED_HISTORY
setopt hist_ignore_dups
setopt hist_ignore_all_dups
autoload -Uz compinit compinit -u
autoload promptinit
compinit
setopt auto_pushd
setopt correct
setopt list_packed
promptinit
prompt redhat

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

# エイリアス
alias ls="ls --color=auto -F"
alias la="ls --color=auto -Fa"
alias ll="ls --color=auto -Fl"
alias lla="ls --color=auto -Fla"
alias chromium="chromium > /dev/null 2>&1&"
alias mikutter="mikutter > /dev/null 2>&1&"
alias libreoffice="libreoffice > /dev/null 2>&1&"
alias grsim="~/nyan/grSim/bin/grsim > /dev/null 2>&1&"
function arduino (){platformio $@ && echo "upload_port = /dev/ttyACM0" >> platformio.ini && echo "void setup(){\n  // put your setup code here, to run once:\n}\nvoid loop(){\n  // put your main code here, to run repeatedly:\n}" > src/main.ino}

# if [ $(ps h -o cmd -p `ps h -o ppid -p $$`) = "xfce4-terminal" ] ; then
#   exec fish
# fi
