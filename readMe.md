---

# IBus Auto Startup

Some Ubuntu/42 environments may lose Korean input settings after reboot or login.

This repository includes an automatic IBus startup script.

## Script

```bash
~/scripts/ibus_setup.sh
```

Example:

```bash
#!/bin/bash

if [ ! -d "/home/jyoo/goinfre/.cache" ]; then
	mkdir -p /home/jyoo/goinfre/.cache
fi

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

ibus-daemon -drx
```

---

# Permission Setup

Give execute permission:

```bash
chmod +x ~/scripts/ibus_setup.sh
```

---

# Ubuntu Auto Startup Registration

## GUI Method

Open:

```text
Startup Applications Preferences
```

Add:

```text
Name:
IBus Setup

Command:
/home/jyoo/scripts/ibus_setup.sh
```

---

## Desktop Entry Method

Create:

```bash
~/.config/autostart/ibus_setup.desktop
```

Content:

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

# Purpose

Automatically restores:

- Korean input
- ibus-daemon
- GTK/QT IM settings

after reboot/login.
