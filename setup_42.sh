#!/bin/bash

USER_NAME="jyoo"
GOINFRE="/goinfre/$USER_NAME"

echo "==== 42 setup start ===="

# 1. 기본 디렉토리
mkdir -p "$GOINFRE"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 2. cache 이동
mkdir -p "$GOINFRE/.cache"
rm -rf "$HOME/.cache"
ln -s "$GOINFRE/.cache" "$HOME/.cache"

# 3. npm cache
mkdir -p "$HOME/.npm"
mkdir -p "$GOINFRE/.npm_cache/_cacache"
mkdir -p "$GOINFRE/.npm_cache/_logs"
mkdir -p "$GOINFRE/.npm_cache/_npx"

rm -rf "$HOME/.npm/_cacache" "$HOME/.npm/_logs" "$HOME/.npm/_npx"
ln -s "$GOINFRE/.npm_cache/_cacache" "$HOME/.npm/_cacache"
ln -s "$GOINFRE/.npm_cache/_logs" "$HOME/.npm/_logs"
ln -s "$GOINFRE/.npm_cache/_npx" "$HOME/.npm/_npx"

# 4. VSCode data
mkdir -p "$GOINFRE/vscode/.vscode"
mkdir -p "$GOINFRE/vscode/Code"
mkdir -p "$GOINFRE/vscode/CodeCache"

mkdir -p "$HOME/.config"

rm -rf "$HOME/.vscode"
rm -rf "$HOME/.config/Code"
rm -rf "$HOME/.cache/Code"

ln -s "$GOINFRE/vscode/.vscode" "$HOME/.vscode"
ln -s "$GOINFRE/vscode/Code" "$HOME/.config/Code"
ln -s "$GOINFRE/vscode/CodeCache" "$HOME/.cache/Code"

# 5. git 기본 설정
git config --global user.name "Sunbear95"
git config --global user.email "jyoo@student.42gyeongsan.kr"
git config --global url."git@github.com:".insteadOf "https://github.com/"

# 6. zsh 설정
touch "$HOME/.zshrc"

grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"

grep -q 'alias lg="lazygit"' "$HOME/.zshrc" || \
echo 'alias lg="lazygit"' >> "$HOME/.zshrc"

grep -q 'autoload -Uz compinit' "$HOME/.zshrc" || cat >> "$HOME/.zshrc" << 'EOF'

autoload -Uz compinit
compinit
EOF

# 7. lazygit 설치
if ! command -v lazygit >/dev/null 2>&1; then
	cd /tmp || exit 1
	LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	mv lazygit "$HOME/.local/bin/lazygit"
	chmod +x "$HOME/.local/bin/lazygit"
	rm -f lazygit.tar.gz
fi

echo "==== setup done ===="
echo "이제 source ~/.zshrc 실행"
echo "SSH 키는 별도로 생성/등록 필요:"
echo "ssh-keygen -t ed25519 -C \"jyoo@student.42gyeongsan.kr\""

# vsc 설정
# 8. VSCode profile import

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROFILE_PATH="$SCRIPT_DIR/vscode/vsc_for_42.code-profile"

if command -v code >/dev/null 2>&1 && [ -f "$PROFILE_PATH" ]; then
	code --profile "vsc_for_42" --import-profile "$PROFILE_PATH"
fi
