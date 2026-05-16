#!/bin/bash

if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx

# 화면 밝기 최대로 설정
gdbus call --session \
--dest org.gnome.SettingsDaemon.Power \
--object-path /org/gnome/SettingsDaemon/Power \
--method org.freedesktop.DBus.Properties.Set \
org.gnome.SettingsDaemon.Power.Screen Brightness "<int32 100>" >/dev/null 2>&1
