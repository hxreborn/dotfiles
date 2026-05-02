#!/bin/bash
# macOS + Asahi disk usage, called with "macos" or "asahi" arg
case "${1:-macos}" in
macos)
  # Query APFS container directly — df lies on snapshot mounts
  info=$(diskutil apfs list disk4 2>/dev/null)
  size=$(echo "$info" | grep "Capacity Ceiling"   | grep -oE '[0-9]+\.[0-9]+ GB')
  free=$(echo "$info" | grep "Not Allocated"       | grep -oE '[0-9]+\.[0-9]+ GB')
  pct=$( echo "$info" | grep "In Use By Volumes"   | grep -oE '[0-9]+\.[0-9]+%')
  printf "%s free / %s (%s used)\n" "$free" "$size" "$pct"
  ;;
asahi)
  diskutil info disk0s7 2>/dev/null | awk -F: '/Disk Size/{gsub(/^[ \t]+/,"",$2); sub(/ \(.*/, "", $2); print $2}' || echo "N/A"
  ;;
esac
