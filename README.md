# dotfiles
my dotfiles

# 環境つくるときのメモ
- Githubから
  - yay
    ```
    $ git clone https://aur.archlinux.org/yay.git
    $ cd yay
    $ makepkg -si
    ```
  - i3blocks
    ```
    $ git clone https://github.com/vivien/i3blocks.git
    $ cd i3blocks
    $ make clean debug
    # make install
    ```
  - base16-xfce4-terminal
    ```
    $ git clone https://github.com/chriskempson/base16-xfce4-terminal.git
    $ cd base16-xfce4-terminal
    $ ./convert2themes
    $ rm themes/*.16.theme
    # cp themes/* /usr/share/xfce4/terminal/colorschemes/
    ```
  - PixivAutoTag.user.js
    ```
    $ git clone https://github.com/syusui-s/PixivAutoTag.user.js.git
    $ vivaldi-stable&
    ```
  - dvorakJP
    ```
    $ git clone https://github.com/27Cobalter/keyboard-layouts.git
    ```
  - mikutter
    ```
    $ git clone git://toshia.dip.jp/mikutter.git
    ```

- 必要なパッケージ
  - acpi
  - clang
  - ctags
  - dmenu
  - fcitx
  - fcitx-config-tool
  - fcitx-mozc
  - feh
  - fzf
  - go
  - i3-wm
  - ninja
  - nvidia (PCに合ったグラフィックドライバ)
  - nvidia-lts
  - nvidia-settings
  - nvidia-utils
  - openssh
  - peco
  - scrot
  - sysstat
  - tmux
  - trash-cli
  - ttf-ricty
  - ttf-symbola
  - urlview
  - vivaldi
  - xbacklight
  - xbindkeys
  - xfce4-terminal
  - xkb-switch
  - xorg-server, xorg-xdpyinfo, xorg-init, xorg-xinput, xorg-xrandr
  - xsel
  - xterm
  - zsh

- あると便利なパッケージ
  - alsa-tools
  - alsa-utils
  - compton
  - lightdm, lightdm-gtk-greeter, lightdm-gkt-greeter-settings
  - mplayer
  - networkmanager, network-manager-applet, wpa_supplicant
  - nmtui
  - thunar
  - ttf-dejavu

- 記述する設定とか
  - audio /etc/asound.conf
    ```text:/etc/asound.conf
    defaults.ctl.card 2
    defaults.pcm.card 2
    ```
  - USBサウンドカードのホットプラグ
    /etc/udev/rules.d/00-local.rules
    ```text:/etc/udev/rules.d/00-local.rules
    KERNEL=="pcmC[D0-9cp]*", ACTION=="add", PROGRAM="/bin/sh -c 'K=%k; K=$${K#pcmC}; K=$${K%%D*}; echo defaults.ctl.card $$K > /etc/asound.conf; echo defaults.pcm.card $$K >>/etc/asound.conf'"
    KERNEL=="pcmC[D0-9cp]*", ACTION=="remove", PROGRAM="/bin/sh -c 'echo defaults.ctl.card 0 > /etc/asound.conf; echo defaults.pcm.card 0 >>/etc/asound.conf'"
    ```
  - mpd
    mpd.conf
    ```text:/mpd.cond
    audio_output {
      type "alsa"
      name "default"
      mixer_type	"software"
    }
    ```
    ```
    # gpasswd -a mpd wheel
    $ chmod 710 $HOME
    ```
