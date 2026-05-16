#!/usr/bin/env bash
set -euo pipefail

# Presses Esc or an arrow key once every random 1-5 minutes.
# Uses X11 directly through Python ctypes, so xdotool is not required.

if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: python3 is required."
  exit 1
fi

echo "Random key presser started. Press Ctrl+C to stop."

while true; do
  sleep_seconds=$((RANDOM % 241 + 60))

  sleep "$sleep_seconds"
  python3 - <<'PY'
import ctypes
import random
import sys
import time

KEYS = {
    "Escape": 0xFF1B,
    "Left": 0xFF51,
    "Up": 0xFF52,
    "Right": 0xFF53,
    "Down": 0xFF54,
}

try:
    x11 = ctypes.cdll.LoadLibrary("libX11.so.6")
    xtst = ctypes.cdll.LoadLibrary("libXtst.so.6")
except OSError:
    print("Error: libX11.so.6 and libXtst.so.6 are required. This script works on X11 sessions.", file=sys.stderr)
    sys.exit(1)

x11.XOpenDisplay.argtypes = [ctypes.c_char_p]
x11.XOpenDisplay.restype = ctypes.c_void_p
x11.XKeysymToKeycode.argtypes = [ctypes.c_void_p, ctypes.c_ulong]
x11.XKeysymToKeycode.restype = ctypes.c_uint
x11.XFlush.argtypes = [ctypes.c_void_p]
x11.XCloseDisplay.argtypes = [ctypes.c_void_p]
xtst.XTestFakeKeyEvent.argtypes = [ctypes.c_void_p, ctypes.c_uint, ctypes.c_bool, ctypes.c_ulong]
xtst.XTestFakeKeyEvent.restype = ctypes.c_int

display = x11.XOpenDisplay(None)
if not display:
    print("Error: could not open X display. Are you running an X11 session?", file=sys.stderr)
    sys.exit(1)

key_name, keysym = random.choice(list(KEYS.items()))
keycode = x11.XKeysymToKeycode(display, keysym)
if keycode == 0:
    print(f"Error: could not resolve keycode for {key_name}.", file=sys.stderr)
    x11.XCloseDisplay(display)
    sys.exit(1)

xtst.XTestFakeKeyEvent(display, keycode, True, 0)
x11.XFlush(display)
time.sleep(random.uniform(0.04, 0.12))
xtst.XTestFakeKeyEvent(display, keycode, False, 0)
x11.XFlush(display)

x11.XCloseDisplay(display)
PY
done
