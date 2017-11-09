#!/bin/sh
case `xkb-switch` in
    "us" )
        sudo sed -i -e "s/<layout>us<\/layout>/<layout>dvorak<\/layout>/g" /usr/share/ibus/component/kkc.xml &&
        sudo sed -i -e "s/<layout>us<\/layout>/<layout>dvorak<\/layout>/g" /usr/share/ibus/component/mozc.xml &&
        sudo sed -i -e "s/<layout>us<\/layout>/<layout>dvorak<\/layout>/g" /usr/share/ibus/component/simple.xml &&
        setxkbmap dvorak && echo "toggle us -> dvorak";;
    "dvorak" )
        sudo sed -i -e "s/<layout>dvorak<\/layout>/<layout>us<\/layout>/g" /usr/share/ibus/component/kkc.xml &&
        sudo sed -i -e "s/<layout>dvorak<\/layout>/<layout>us<\/layout>/g" /usr/share/ibus/component/mozc.xml &&
        sudo sed -i -e "s/<layout>dvorak<\/layout>/<layout>us<\/layout>/g" /usr/share/ibus/component/simple.xml &&
        setxkbmap us && echo "toggle dvorak -> us";;
esac
ibus-daemon -drx
