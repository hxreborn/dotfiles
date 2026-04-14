#!/bin/bash
df -hT / | awk 'NR==2{printf "%s / %s (%s) - %s\n", $4, $3, $6, $2}'
