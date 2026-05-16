#!/bin/bash

if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx

# 화면 밝기 최대로 설정
if command -v brightnessctl >/dev/null 2>&1; then
	brightnessctl set 100%
elif command -v xrandr >/dev/null 2>&1; then
	xrandr --output "$(xrandr | awk '/ connected primary/{print $1; exit} / connected/{print $1; exit}')" --brightness 1
fi
