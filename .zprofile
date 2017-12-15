export PATH=$PATH:~/.sh
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.gem/ruby/2.4.0/bin
export PATH=$PATH:/opt/cuda/bin
export GOPATH=~/go
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
