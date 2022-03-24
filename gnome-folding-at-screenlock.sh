#!/usr/bin/env sh

dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver'" |
# Somehow I receive duplicate signals during locking and unlocking.
# It's a weird behavior but does no harm in our case.
  while read x; do
    case "$x" in
    "boolean true")
      echo "screen turns locked. Initiate folding" && FAHClient --send-unpause ;;
    "boolean false") echo "screen turns unlocked. Unfold! Unfold!" && FAHClient --send-pause ;;
    *) ;;
    esac
  done
