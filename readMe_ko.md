---

# IBus 한글 입력 자동 실행

42 Ubuntu 환경에서는 재부팅 또는 로그인 이후 한글 입력 설정이 초기화되는 경우가 있습니다.

이를 해결하기 위해 IBus 자동 실행 스크립트를 사용합니다.

---

# 스크립트 위치

```bash
~/scripts/ibus_setup.sh
```

예시:

```bash
#!/bin/bash

# goinfre cache 폴더 생성
if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

# ibus 환경 변수 설정
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# ibus 실행
ibus-daemon -drx
```

---

# 실행 권한 부여

```bash
chmod +x ~/scripts/ibus_setup.sh
```

---

# Ubuntu 시작 프로그램 등록

## GUI 방식

Ubuntu에서:

```text
Startup Applications Preferences
```

검색 후 실행.

추가:

```text
Name:
IBus Setup

Command:
/home/jyoo/scripts/ibus_setup.sh
```

---

## autostart 방식

생성 위치:

```bash
~/.config/autostart/ibus_setup.desktop
```

내용:

```ini
[Desktop Entry]
Type=Application
Exec=/home/jyoo/scripts/ibus_setup.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=IBus Setup
Comment=Start ibus automatically
```

---

# 목적

로그인/재부팅 이후 자동으로:

- 한글 입력 복구
- ibus-daemon 실행
- GTK/QT 입력 환경 변수 설정

을 수행합니다.
