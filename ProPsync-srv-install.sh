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
apt-get install -y git apache2 php5 php5-ssh2
service apache2 restart
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
mkdir /home/$un
chown $un /home/$un
echo User setup completed.
ip=$(curl -s http://whatismijnip.nl |cut -d " " -f 5)
echo "If you have a URL, please enter it below; otherwise, use your public IP."
echo "Make sure to forward port 22 and 80 to this device.  Or... if you only want to use this internally, just enter your internal IP below."
echo "You can also just forward port 22 to this device if you initially configure your client sync applications using the internal IP instead"
echo "of your public IP or URL.  This is much more secure, but requires any client devices to be on the internal network for initial setup."
echo -n "["$ip"]: "
dns=''
read dns
if [ "$dns" = '' ]; then
  dns="$ip"
fi
echo "Please enter where you would like the data stored by default ["$sr"]: "
read sralt
if [ ! "$sralt" = '' ]; then
  sr="$sralt"
fi
if [ -d $sr ]; then
  echo "Directory already exists.  If you continue, all contents will be removed.  Do you want to continue?"
  echo -n "[n]: "
  read continue
  if [ "$continue" = '' ]; then
    continue='n'
  fi
  if [ ! [ "$continue" = 'y' ] || [ "$continue" = 'Y' ] ]; then
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
git clone https://github.com/ProPsync/AdminPage.git /var/www/html
echo '<dns>'$dns'</dns>'>/var/www/html/config.txt
echo '<mediarepo>'$sr$media'</mediarepo>'>>/var/www/html/config.txt
echo '<libraryrepo>'$sr$library'</libraryrepo>'>>/var/www/html/config.txt
echo '<prefrepo>'$sr$pref'</prefrepo>'>>/var/www/html/config.txt
echo '<syncmedia>True</syncmedia>'>>/var/www/html/config.txt
echo '<synclibrary>True</synclibrary>'>>/var/www/html/config.txt
echo '<syncpref>True</syncpref>'>>/var/www/html/config.txt
echo '<automode>True</automode>'>>/var/www/html/config.txt
mkdir /var/www/auths
chown www-data /var/www/auths
chmod 755 /var/www/auths
chown www-data /var/www/html/config.txt
chmod 755 /var/www/html/config.txt
echo 'Installation completed.'