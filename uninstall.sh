#!/usr/bin/env bash
# Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
# This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)

systemctl stop webra1n
systemctl disable webra1n
rm /etc/systemd/system/webra1n.service
systemctl daemon-reload
# remove systemd service

cp /etc/sudoers.beforewebra1n /etc/sudoers  || fatal "Couldn't use /etc/sudoers backup"
deluser checkra1n
# remove checkra1n user

rm /usr/bin/checkra1n
rm /usr/bin/webra1n
rm /usr/bin/checkra1nunkillable
# remove compilated executable from PATH

rm checkra1n
rm checkra1nunkillable/checkra1nunkillable
rm webra1nlauncher/webra1n
# remove compilated executable from here
