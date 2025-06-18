# PATHの設定
export PATH=~/.local/bin:$PATH

export PATH="$HOME/.cargo/bin:$PATH"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/wsl/lib:$LD_LIBRARY_PATH

export PATH=$PATH:~/.sh
export BROWSER=/usr/bin/vivaldi-stable

export QT_QPA_PLATFORMTHEME=qt6ct

source ~/.env

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
