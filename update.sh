#!/usr/bin/env bash
# Lloir - 2020 - (github:Lloir)
# This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)

# Stop services prior to update
  systemctl stop webra1n
  systemctl disable webra1n
  
# Remove the older binaries

rm /usr/bin/checkra1n
rm /usr/bin/webra1n
rm /usr/bin/checkra1nunkillable

./checkra1n-downloader/checkra1n-downloader.sh || fatal "Checkra1n-Download.sh failed"
chmod +x checkra1n || fatal "Looks like we can't edit permissions of checkra1n executable"
cp checkra1n /usr/bin/checkra1n || fatal "Couldn't move checkra1n in /usr/bin"

# Recompile webra1n
gcc webra1nlauncher/webra1nlauncher.c -o webra1nlauncher/webra1n || fatal "webra1nlauncher compilation failed"
chmod +x webra1nlauncher/webra1n || fatal "Looks like we can't edit permissions of webra1n launcher"
cp webra1nlauncher/webra1n /usr/bin/webra1n || fatal "Couldn't move webra1n in /usr/bin"

# Restart everything
systemctl daemon-reload
systemctl enable webra1n
systemctl start webra1n
