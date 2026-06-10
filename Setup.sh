#!/bin/bash

USER_NAME="jyoo"
GOINFRE="/goinfre/$USER_NAME"

# setup.sh 절대경로 고정
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

DOWNLOAD_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"

echo "==== 42 setup start ===="

# =========================
# 1. 기본 디렉토리 생성
# =========================

mkdir -p "$GOINFRE"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.ssh"
mkdir -p "$HOME/Documents"

chmod 700 "$HOME/.ssh"

# =========================
# 2. ~/.cache -> goinfre 연결
# =========================

mkdir -p "$GOINFRE/.cache"

if [ ! -e "$HOME/.cache" ]; then
	ln -s "$GOINFRE/.cache" "$HOME/.cache"
elif [ -L "$HOME/.cache" ]; then
	echo "~/.cache is already a symbolic link."
else
	echo "WARNING: ~/.cache already exists and is not a symlink. Skip cache linking."
fi

# =========================
# 3. npm cache -> goinfre
# =========================

mkdir -p "$HOME/.npm"

mkdir -p "$GOINFRE/.npm_cache/_cacache"
mkdir -p "$GOINFRE/.npm_cache/_logs"
mkdir -p "$GOINFRE/.npm_cache/_npx"

rm -rf "$HOME/.npm/_cacache"
rm -rf "$HOME/.npm/_logs"
rm -rf "$HOME/.npm/_npx"

ln -s "$GOINFRE/.npm_cache/_cacache" "$HOME/.npm/_cacache"
ln -s "$GOINFRE/.npm_cache/_logs" "$HOME/.npm/_logs"
ln -s "$GOINFRE/.npm_cache/_npx" "$HOME/.npm/_npx"

# =========================
# 4. Git 설정
# =========================

git config --global user.name "Sunbear95"
git config --global user.email "dbwofldb@naver.com"

git config --global \
url."git@github.com:".insteadOf \
"https://github.com/"

# =========================
# 5. SSH 키 생성
# =========================

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
	ssh-keygen -t ed25519 \
	-C "jyoo@student.42gyeongsan.kr" \
	-f "$HOME/.ssh/id_ed25519" \
	-N ""
fi

chmod 600 "$HOME/.ssh/id_ed25519"
chmod 644 "$HOME/.ssh/id_ed25519.pub"

cat "$HOME/.ssh/id_ed25519.pub" > "$SCRIPT_DIR/ssh_key"

chmod 644 "$SCRIPT_DIR/ssh_key"

# =========================
# 6. wget 설치 시도
# =========================

if ! command -v wget >/dev/null 2>&1; then
	if command -v sudo >/dev/null 2>&1; then
		sudo apt update
		sudo apt install -y wget
	else
		echo "WARNING: wget is not installed and sudo is unavailable."
	fi
fi

# =========================
# 7. VSCode tar.gz 다운로드
# =========================

if command -v wget >/dev/null 2>&1; then
	if [ ! -f "$HOME/Documents/code-linux-x64.tar.gz" ]; then
		wget -O \
		"$HOME/Documents/code-linux-x64.tar.gz" \
		"$DOWNLOAD_URL"
	else
		echo "SKIP: code-linux-x64.tar.gz already exists"
	fi
fi

# =========================
# 8. lazygit 설치
# =========================

if ! command -v lazygit >/dev/null 2>&1 && \
[ ! -x "$HOME/.local/bin/lazygit" ]; then

	TMP_DIR="$(mktemp -d)"

	LAZYGIT_VERSION=$(
		curl -s \
		https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
		grep -Po '"tag_name": "v\K[^"]*'
	)

	curl -Lo "$TMP_DIR/lazygit.tar.gz" \
	"https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

	tar xf "$TMP_DIR/lazygit.tar.gz" \
	-C "$TMP_DIR" lazygit

	mv "$TMP_DIR/lazygit" \
	"$HOME/.local/bin/lazygit"

	chmod +x "$HOME/.local/bin/lazygit"

	rm -rf "$TMP_DIR"
fi

# =========================
# 9. zsh 설정
# =========================

touch "$HOME/.zshrc"

grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"

grep -q 'alias lg="lazygit"' "$HOME/.zshrc" || \
echo 'alias lg="lazygit"' >> "$HOME/.zshrc"

grep -q 'autoload -Uz compinit' "$HOME/.zshrc" || cat >> "$HOME/.zshrc" << 'EOF'

autoload -Uz compinit
compinit
EOF


# =========================
# 10. Desktop Entry 등록
# =========================

mkdir -p "$HOME/.local/share/applications"

if [ -f "$SCRIPT_DIR/code-portable.desktop" ]; then

	cp "$SCRIPT_DIR/code-portable.desktop" \
	"$HOME/.local/share/applications/code-portable.desktop"

	chmod +x \
	"$HOME/.local/share/applications/code-portable.desktop"
fi

# =========================
# 11. Auto.sh 시작 프로그램 등록
# =========================

AUTO_SCRIPT="$SCRIPT_DIR/Auto.sh"

AUTOSTART_DIR="$HOME/.config/autostart"
AUTOSTART_FILE="$AUTOSTART_DIR/42-auto.desktop"

mkdir -p "$AUTOSTART_DIR"

if [ -f "$AUTO_SCRIPT" ]; then

	chmod +x "$AUTO_SCRIPT"

	cat > "$AUTOSTART_FILE" << EOF
[Desktop Entry]
Type=Application
Exec=$AUTO_SCRIPT
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=42 Auto Setup
Comment=Run 42 environment auto setup script
EOF

	chmod 644 "$AUTOSTART_FILE"

	echo "Auto.sh registered to Startup Applications."

	# setup.sh 실행 시 즉시 1회 실행
	"$AUTO_SCRIPT"

else
	echo "WARNING: Auto.sh not found in $SCRIPT_DIR"
fi

echo "==== setup done ===="

echo "이제 source ~/.zshrc 실행"

echo "GitHub에 등록할 공개키:"
echo "$SCRIPT_DIR/ssh_key"

echo "확인 명령어:"
echo "cat \"$SCRIPT_DIR/ssh_key\""
