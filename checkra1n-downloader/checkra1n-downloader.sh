#!/bin/bash
# Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
# This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
# Script that downloads checkra1n for your arch

fatal() {
	echo -e "$*"
	exit 1
}

links=$(curl -sL "https://checkra.in/releases" | grep 'class="download-btn"' | sed -n 's/.*href="\(.*\)".*/\1/p' | grep -Eo '(http|https)://(.*)checkra1n' || fatal "Unable to get download links")
# here we get all download link, might get broken if web designer change the way links are made

arch=$(uname -m)
# here we get arch

if [ "$(echo "$links" | grep "$arch")" ]; then
  link=$(echo "$links" | grep "$arch")
else
  fatal "Looks like we can't download checkra1n for you architecture ($arch)"
fi

link=$(echo "$links" | grep "$arch")
# here we have the link corresponding to machine's arch

wget "$link" -O "checkra1n"
