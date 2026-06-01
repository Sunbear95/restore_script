#!/bin/bash

USER_NAME="jyoo"
GOINFRE="/goinfre/$USER_NAME"

# .cache to goinfre
mkdir -p "$GOINFRE/.cache"

if [ -L "$HOME/.cache" ]; then
	echo "~/.cache is already a symbolic link."
elif [ -d "$HOME/.cache" ]; then
	mv "$HOME/.cache" "$HOME/.cache_backup_$(date +%Y%m%d_%H%M%S)"
	ln -s "$GOINFRE/.cache" "$HOME/.cache"
else
	ln -s "$GOINFRE/.cache" "$HOME/.cache"
fi

ibus-daemon -rxRd

# .npm cache to goinfre
mkdir -p "$HOME/.npm"
mkdir -p "$GOINFRE/.npm_cache/_cacache"
mkdir -p "$GOINFRE/.npm_cache/_logs"
mkdir -p "$GOINFRE/.npm_cache/_npx"

if [ ! -L "$HOME/.npm/_cacache" ]; then
	rm -rf "$HOME/.npm/_cacache"
	ln -s "$GOINFRE/.npm_cache/_cacache" "$HOME/.npm/_cacache"
fi

if [ ! -L "$HOME/.npm/_logs" ]; then
	rm -rf "$HOME/.npm/_logs"
	ln -s "$GOINFRE/.npm_cache/_logs" "$HOME/.npm/_logs"
fi

if [ ! -L "$HOME/.npm/_npx" ]; then
	rm -rf "$HOME/.npm/_npx"
	ln -s "$GOINFRE/.npm_cache/_npx" "$HOME/.npm/_npx"
fi

# install vscode to goinfre
if [ ! -d "$HOME/goinfre/VSCode-linux-x64" ]; then
	tar -xzf "$HOME/Documents/code-linux-x64.tar.gz" -C "$HOME/goinfre"
	update-desktop-database "$HOME/.local/share/applications" 2>/dev/null
fi

# 화면 밝기 최대로 설정
gdbus call --session \
--dest org.gnome.SettingsDaemon.Power \
--object-path /org/gnome/SettingsDaemon/Power \
--method org.freedesktop.DBus.Properties.Set \
org.gnome.SettingsDaemon.Power.Screen Brightness "<int32 100>" >/dev/null 2>&1
