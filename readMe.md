# 42 Dev Setup

Development environment setup script for the 42 Gyeongsan Ubuntu cluster environment.

This repository automates:

- goinfre cache setup
- npm cache setup
- GitHub SSH preparation
- lazygit installation
- wget installation attempt
- VSCode tar.gz download
- desktop entry registration
- zsh configuration

It also includes an automatic startup script for Ubuntu login sessions.

---

# Features

## goinfre Optimization

Automatically prepares:

```bash
/goinfre/$USER
```

cache-related directories.

Applied targets:

- `~/.cache`
- `~/.npm/_cacache`
- `~/.npm/_logs`
- `~/.npm/_npx`

This reduces HOME storage usage after 42 resets.

---

## GitHub SSH Preparation

Automatically:

- creates SSH key if missing
- sets correct permissions
- exports public key into:

```bash
ssh_key
```

This file can be copied directly into GitHub SSH settings.

---

## lazygit Installation

Installs latest lazygit locally without sudo:

```bash
~/.local/bin/lazygit
```

Adds:

```bash
alias lg="lazygit"
```

to `.zshrc`.

---

## VSCode Portable Download

Downloads VSCode tar.gz into:

```bash
~/Documents/code-linux-x64.tar.gz
```

---

## Desktop Entry Registration

Automatically copies:

```bash
code-portable.desktop
```

into:

```bash
~/.local/share/applications
```

This allows VSCode Portable to appear in Ubuntu application search.

---

# Startup Script

The repository also includes an automatic startup script:

```bash
~/scripts/lang.sh
```

This script automatically:

- starts ibus-daemon
- restores brightness
- prepares goinfre cache
- extracts VSCode Portable if missing

---

# Repository Structure

```text
42-dev-setup/
├── setup_42.sh
├── README.md
├── code-portable.desktop
├── ssh_key
└── scripts/
```

---

# Installation

Clone repository:

```bash
git clone git@github.com:Sunbear95/42-dev-setup.git
cd 42-dev-setup
```

Give execute permission:

```bash
chmod +x setup_42.sh
```

Run setup:

```bash
./setup_42.sh
source ~/.zshrc
```

---

# After Running The Script

## 1. Register SSH Key On GitHub

Display public key:

```bash
cat ssh_key
```

GitHub path:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

Paste the contents of:

```bash
ssh_key
```

into GitHub.

---

## 2. Test GitHub SSH Connection

```bash
ssh -T git@github.com
```

Expected output:

```text
Hi Sunbear95! You've successfully authenticated...
```

---

## 3. Verify lazygit

Inside a git repository:

```bash
lg
```

---

## 4. Register Startup Script

Ubuntu:

```text
Startup Applications Preferences
```

Add:

```text
Name:
42 Startup Script

Command:
/home/jyoo/scripts/lang.sh
```

---

# Warning

Do NOT upload:

```text
~/.ssh/id_ed25519
tokens
.env
private keys
```

---

# Notes

This setup is intended for:

- 42 Gyeongsan
- Ubuntu/Linux
- HOME reset recovery
- goinfre optimization

---

# 42 개발 환경 자동화 세팅

42 경산 Ubuntu 클러스터 환경용 개발 환경 자동화 스크립트입니다.

이 저장소는 다음 작업들을 자동화합니다.

- goinfre cache 설정
- npm cache 설정
- GitHub SSH 준비
- lazygit 설치
- wget 설치 시도
- VSCode tar.gz 다운로드
- desktop entry 등록
- zsh 설정

또한 Ubuntu 로그인 시 자동 실행되는 startup script도 포함합니다.

---

# 주요 기능

## goinfre 최적화

다음 cache 디렉토리들을 준비합니다.

```bash
/goinfre/$USER
```

적용 대상:

- `~/.cache`
- `~/.npm/_cacache`
- `~/.npm/_logs`
- `~/.npm/_npx`

42 HOME 리셋 이후 용량 문제를 줄일 수 있습니다.

---

## GitHub SSH 준비

자동으로:

- SSH 키 생성
- 권한 설정
- 공개키를:

```bash
ssh_key
```

파일로 저장

합니다.

GitHub 등록 시 이 파일 내용을 그대로 복사하면 됩니다.

---

## lazygit 설치

sudo 없이 최신 lazygit을 설치합니다.

설치 위치:

```bash
~/.local/bin/lazygit
```

추가 설정:

```bash
alias lg="lazygit"
```

---

## VSCode Portable 다운로드

다음 위치에:

```bash
~/Documents/code-linux-x64.tar.gz
```

VSCode tar.gz 파일을 다운로드합니다.

---

## Desktop Entry 등록

자동으로:

```bash
code-portable.desktop
```

파일을:

```bash
~/.local/share/applications
```

로 복사합니다.

Ubuntu 앱 검색에서 VSCode Portable을 실행할 수 있게 됩니다.

---

# Startup Script

다음 자동 실행 스크립트가 포함되어 있습니다.

```bash
~/scripts/lang.sh
```

이 스크립트는 자동으로:

- ibus-daemon 실행
- 화면 밝기 복구
- goinfre cache 준비
- VSCode Portable 압축 해제

를 수행합니다.

---

# 저장소 구조

```text
42-dev-setup/
├── setup_42.sh
├── README.md
├── code-portable.desktop
├── ssh_key
└── scripts/
```

---

# 설치 방법

저장소 clone:

```bash
git clone git@github.com:Sunbear95/42-dev-setup.git
cd 42-dev-setup
```

실행 권한 부여:

```bash
chmod +x setup_42.sh
```

스크립트 실행:

```bash
./setup_42.sh
source ~/.zshrc
```

---

# 스크립트 실행 후 해야 할 작업

## 1. GitHub에 SSH 공개키 등록

공개키 확인:

```bash
cat ssh_key
```

GitHub 경로:

```text
GitHub
→ Settings
→ SSH and GPG keys
→ New SSH key
```

`ssh_key` 파일 내용을 붙여넣기 하면 됩니다.

---

## 2. GitHub SSH 연결 테스트

```bash
ssh -T git@github.com
```

정상 결과:

```text
Hi Sunbear95! You've successfully authenticated...
```

---

## 3. lazygit 확인

Git 레포 안에서:

```bash
lg
```

실행 확인.

---

## 4. Startup Script 등록

Ubuntu에서:

```text
Startup Applications Preferences
```

검색 후 실행.

추가:

```text
Name:
42 Startup Script

Command:
/home/jyoo/scripts/lang.sh
```

---

# 주의사항

절대 업로드하지 마세요:

```text
~/.ssh/id_ed25519
토큰
.env
개인 키
```

---

# 목적

이 세팅은 다음 환경을 기준으로 제작되었습니다.

- 42 경산
- Ubuntu/Linux
- HOME 리셋 대응
- goinfre 최적화
