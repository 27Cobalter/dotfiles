# PATHの設定
export PATH=~/.local/bin:$PATH

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

export PATH=$PATH:~/.sh
export BROWSER=/usr/bin/vivaldi-stable
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
