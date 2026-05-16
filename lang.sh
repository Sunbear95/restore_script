#!/bin/bash

# goinfre cache 폴더 없으면 생성
if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

# ibus 자동 실행
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx
