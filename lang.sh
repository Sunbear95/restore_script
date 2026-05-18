#!/bin/bash

USER_NAME="jyoo"
GOINFRE="/goinfre/$USER_NAME"

# =========================
# 1. goinfre 기본 폴더 생성
# =========================

mkdir -p "$GOINFRE/.cache"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.cache"
mkdir -p /home/jyoo/goinfre/.npm_cache/_logs
mkdir -p /home/jyoo/goinfre/.npm_cache/_npx
fi


# =========================
# 3. IBus 한글 입력 설정
# =========================

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx >/dev/null 2>&1


# =========================
# 4. 화면 밝기 최대로 설정
# =========================

gdbus call --session \
--dest org.gnome.SettingsDaemon.Power \
--object-path /org/gnome/SettingsDaemon/Power \
--method org.freedesktop.DBus.Properties.Set \
org.gnome.SettingsDaemon.Power.Screen Brightness "<int32 100>" >/dev/null 2>&1


