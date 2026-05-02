#!/bin/bash
PAC=$(pacman -Q 2>/dev/null | wc -l)
FLAT=$(flatpak list --app 2>/dev/null | wc -l)
OUT="$PAC (pacman)"
[ "$FLAT" -gt 0 ] && OUT="$OUT, $FLAT (flatpak)"
echo "$OUT"
