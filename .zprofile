# PATHの設定
export PATH=~/.local/bin:$PATH

export GOPATH=~/go
export PATH=$PATH:~/.sh
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.gem/ruby/2.4.0/bin
export PATH=$PATH:~/.gem/ruby/2.5.0/bin
export PATH=$PATH:/opt/cuda/bin
export AI=~/ai-server
export BROWSER=/usr/bin/vivaldi-stable
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
