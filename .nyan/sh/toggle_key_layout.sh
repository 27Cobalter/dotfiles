#!/bin/sh
case `xkb-switch` in
    "us" ) setxkbmap dvorak && echo "toggle us -> dvorak";;
    "dvorak" ) setxkbmap us && echo "toggle dvorak -> us";;
esac
