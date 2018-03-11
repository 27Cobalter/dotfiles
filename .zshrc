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

autoload -Uz compinit compinit-u promptinit -U colors -Uz vcs_info
compinit
colors
promptinit
zmodload zsh/zpty
setopt auto_pushd
setopt auto_cd
setopt correct
setopt list_packed
setopt no_beep
setopt prompt_subst
ALLOW=$'\u2b80'
ALLOW2=$'\u2b81'
UPPERALLOW=$'\u2b11'
zstyle ':vcs_info:*' formats '%F{black}[%s][* %F{green}%b%F{black}]%f'
zstyle ':vcs_info:*' actionformats '%F{black}[%s][* %F{green}%b%F{black}(%F{red}%a%F{black})%F{black}]%f'
precmd(){ vcs_info }
prompt="%(?.%K{green}.%K{red})%F{black}${UPPERALLOW} [\$history[\$((\$HISTCMD-1))]]->(%?)%k%(?.%F{green}.%F{red})$ALLOW
%F{white}%K{blue}$USER%F{red}@%F{magenta}$HOST%F{blue}%K{cyan}$ALLOW%F{black}%K{cyan}%~%F{cyan}%K{white}$ALLOW\$vcs_info_msg_0_%F{white}%k$ALLOW
%F{red}${ALLOW2}%F{yellow}${ALLOW2}%F{green}${ALLOW2}%f "

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
alias chromium="chromium > /dev/null 2>&1&"
alias libreoffice="libreoffice > /dev/null 2>&1&"
function arduino (){platformio $@ && ln -s $HOME/arduino/.piolibdeps .piolibdeps && echo "upload_port = /dev/ttyUSB0" >> platformio.ini && echo "#include<ArduinoSTL.h>\n\nvoid setup(){\n  // put your setup code here, to run once:\n}\nvoid loop(){\n  // put your main code here, to run repeatedly:\n}" > src/main.ino}
alias cat="lolcat"

if which trash-put &>/dev/null; then
  alias rm=trash-put
fi

if [ ! -e ~/.autojump ]; then
  printf 'install autojump? [y/N]: '
  if read -q; then
    git clone https://github.com/wting/autojump.git ~/.autojump
    ./.autojump/install.py
  fi
fi
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

if ! which peco &>/dev/null; then
  [[ $- != *i* ]] && return
  [[ -z "$TMUX" ]] && exec tmux
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cobalt/.nyan/google-cloud-sdk/path.zsh.inc' ]; then source '/home/cobalt/.nyan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cobalt/.nyan/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/cobalt/.nyan/google-cloud-sdk/completion.zsh.inc'; fi

# pecoでhistory検索
function peco-select-history(){
  BUFFER=$(\history -n 1 | tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# fzfでhistory検索
function fzf-select-history(){
  BUFFER=$(\history -n 1 | tac | awk '!a[$0]++' | fzf --reverse --height 50% --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N fzf-select-history
# ESC R
bindkey '^[r' fzf-select-history

# pecoでkill
function peco-kill(){
  ps -aux | peco | awk '{ print "kill ", $2 }' | sh | cat /dev/stdin
}
# fzfでkill
function fzf-kill(){
  ps -aux | fzf --reverse --height 50% | awk '{ print "kill ", $2 }' | sh | cat /dev/stdin
}

# pecoでtmuxのセッションを選択
if [[ ! -n "$TMUX" ]]; then
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    exec tmux new-session
  fi
  create_new_session="Create New Session"
  ID="${create_new_session}:\n${ID}"
  ID="`echo $ID | peco | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    exec tmux new-session
  elif [[ -n "$ID" ]]; then
    exec tmux attach-session -t $ID
  fi
fi
