#!/bin/bash

# .cache to goinfre
if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

ibus-daemon -rxRd

# .npm cache to goinfre
if [ ! -d "/home/jyoo/goinfre/.npm_cache" ]; then
	mkdir -p /home/jyoo/goinfre/.npm_cache
	mkdir -p /home/jyoo/goinfre/.npm_cache/_cacache
	mkdir -p /home/jyoo/goinfre/.npm_cache/_logs
	mkdir -p /home/jyoo/goinfre/.npm_cache/_npx
fi

# install vscode to goinfre
if [ ! -d "/home/jyoo/goinfre/VSCode-linux-x64" ]; then
	tar -xzf /home/jyoo/Documents/code-linux-x64.tar.gz -C /home/jyoo/goinfre
	update-desktop-database ~/.local/share/applications 2>/dev/null
fi

# 화면 밝기 최대로 설정
gdbus call --session \
--dest org.gnome.SettingsDaemon.Power \
--object-path /org/gnome/SettingsDaemon/Power \
--method org.freedesktop.DBus.Properties.Set \
org.gnome.SettingsDaemon.Power.Screen Brightness "<int32 100>" >/dev/null 2>&1
