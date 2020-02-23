#!/usr/bin/env bash
# Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
# This script is part of Webra1n As a Service (github:jusdepatate/webra1n-as-a-service)
# It was meant to be the script to run to install everything

fatal() {
  echo "$*"
  exit 1
}

if [ ! "$(whoami)" = "root" ]; then fatal "Please execute this script as root"; fi
# Make sure the user is root, if not exit

if [[ -z "$1" ]] || [[ "$1" = "install" ]]; then
  ./checkra1n-downloader/checkra1n-downloader.sh || fatal "Checkra1n-Download.sh failed"
  chmod +x checkra1n || fatal "Looks like we can't edit permissions of checkra1n executable"
  cp checkra1n /usr/bin/checkra1n || fatal "Couldn't move checkra1n in /usr/bin"
  # run Checkra1n downloader and install checkra1n, if it works we should have a file named `checkra1n` in the working directory and in /usr/bin/

  gcc webra1nlauncher/webra1nlauncher.c -o webra1nlauncher/webra1n || fatal "webra1nlauncher compilation failed"
  chmod +x webra1nlauncher/webra1n || fatal "Looks like we can't edit permissions of webra1n launcher"
  cp webra1nlauncher/webra1n /usr/bin/webra1n || fatal "Couldn't move webra1n in /usr/bin"
  # compilate the webra1n launcher
  # Why do I need a launcher for webra1n ?
  # Because checkra1n isn't that good and give bad success code to system which makes systemd to think that its dead

  gcc checkra1nunkillable/checkra1nunkillable.c -o checkra1nunkillable/checkra1nunkillable || fatal "checkra1nunkillable compilation failed"
  chmod +x checkra1nunkillable/checkra1nunkillable || fatal "Looks like we can't edit permissions of checkra1nunkillable executable"
  cp checkra1nunkillable/checkra1nunkillable /usr/bin/checkra1nunkillable || fatal "Couldn't move checkra1nunkillable in /usr/bin"
  # compilates checkra1nunkillable
  # it will simply make the checkra1n process un-^-C-able so that we can jail ssh connections to checkra1n

  useradd -m checkra1n -p "sayCaPlF0Sac." || fatal "Couldn't create user checkra1n"
  # add user 'checkra1n' to system with password 'checkra1n' (crypted with `perl -e 'print crypt("checkra1n", "salt")'`)

  cp /etc/sudoers /etc/sudoers.beforewebra1n || fatal "Couldn't backup /etc/sudoers"
  echo "checkra1n ALL = NOPASSWD: /usr/bin/checkra1nunkillable, /usr/bin/checkra1n, /usr/bin/webra1n" | sudo EDITOR='tee -a' visudo || fatal "Couldn't add checkra1n to sudoers for /usr/bin/checkra1n"
  # here we give permissions to user checkra1n to run `checkra1nunkillable`, `checkra1n` and `webra1n` as root without typing password

  chsh --shell /bin/bash checkra1n || fatal "Couldn't change checkra1n's shell to /bin/bash"
  cp bashrc ~checkra1n/.bashrc || fatal "Couldn't put .bashrc in ~checkra1n"
  # here we change checkra1n's shell and put our bashrc inside it

  cp webra1n.service /etc/systemd/system/webra1n.service || fatal "Couldn't put webra1n.service in /etc/systemd/system/"
  systemctl daemon-reload
  systemctl enable webra1n
  systemctl start webra1n
  # add webra1n.service to systemd services and enable it (=start it at reboots)

elif [[ "$1" = "uninstall" ]] || [[ "$1" = "remove" ]]; then
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
else
  echo "Webra1n-As-a-Service"
  echo "Jus de Patate - 2020 - jusdepatate@protonmail.com"
  echo ""
  echo "The only accepted arguments are:"
  echo "install - To install webra1n"
  echo "unistall - To remove webra1n"
fi