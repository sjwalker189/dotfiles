#!/usr/bin/bash

xmodmap -e "clear lock"
xmodmap -e "keysym CapsLock = Escape"
set caps_lock as escape
