#!/bin/bash


# Default settings:

# Storage root:
sr='/ProPsyncStorage/'

# Folder for media:
media='media.git'

# Folder for presentation library:
library='library.git'

# Folder for preferences/playlists:
pref='pref.git'



# Installation:

apt-get update
apt-get -y upgrade
apt-get install -y git apache2
clear

echo '                                                       '
echo '       _____           _____                           '
echo '      |  __ \         |  __ \                          '
echo '      | |__) | __ ___ | |__) |__ _   _ _ __   ___      '
echo '      |  ___/  ''''__/ _ \|  ___/ __| | | |  ''''_ \ / __|     '
echo '      | |   | | | (_) | |   \__ \ |_| | | | | (__      '
echo '      |_|   |_|  \___/|_|   |___/\__, |_| |_|\___|     '
echo '                                  __/ |                '
echo '                                 |___/                 '
echo '                                                       '
echo '                                                       '
echo "Please enter your desired username (no spaces), then press [ENTER]: "
read un
useradd $un
passwd $un
clear
echo User setup completed.
ip=$(curl -s http://whatismijnip.nl |cut -d " " -f 5)
echo "If you have a URL, please enter it below; otherwise, use your public IP.  Make sure to forward port 22 to this device. ["$ip"]: "
read dns
if [ $dns = '' ]; then
  dns=$ip
fi
echo "Please enter where you would like the data stored by default ["$sr"]: "
read sralt
if [ ! $sralt = '' ]; then
  sr=$sralt
fi
if [ -d $sr ]; then
  echo "Directory already exists.  If you continue, all contents will be removed.  Do you want to continue? [n]: "
  read continue
  if [ $continue = '' ]; then
    continue='n'
  fi
  if [ ! [ $continue = 'y' ] || [ $continue = 'Y' ] ]; then
    echo Installation canceled.
    exit
  else
    rm -rf $sr
  fi
fi
mkdir $sr
mkdir $sr$media
mkdir $sr$library
mkdir $sr$pref
cd $sr$media
git init --bare
cd $sr$library
git init --bare
cd $sr$pref
git init --bare
chmod -R 777 $sr
echo '<dns>'$dns'</dns>'>/var/www/html/config.txt
echo '<mediarepo>'$sr$media'</mediarepo>'>>/var/www/html/config.txt
echo '<libraryrepo>'$sr$media'</libraryrepo>'>>/var/www/html/config.txt
echo '<prefrepo>'$sr$pref'</prefrepo>'>>/var/www/html/config.txt
echo '<syncmedia>True</syncmedia>'>>/var/www/html/config.txt
echo '<synclibrary>True</synclibrary>'>>/var/www/html/config.txt
echo '<syncpref>True</syncpref>'>>/var/www/html/config.txt
echo 'Installation completed.'