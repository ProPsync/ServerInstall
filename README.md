# ProPsync Server installation instructions


## Server environment:
The ProPsync server was designed to be run from Debian 8.5 or above, but has also been tested on Ubuntu 16.04.1.  In theory, it should be able to run on any Debian varient.  It can also run on a Rasberry Pi running Raspbian Jessie Lite.
Whatever clients are accessing the sync application will need to access port 80 during setup (after setup port 80 is no longer necessary), and port 22.  Port 22 should always be available to the clients.  If you need to specify a different port that will be forwarded to the server's port 22 via NAT, specify that port when you hit the "DNS" settings in the server install script.  (For instance: [dns or IP]:port)
The ports shouldn't be a problem if you are running everything on the same network and do not need to access the sync application outside of that network.

During installation, the script must be run as root (sudo will probably not work).  If you are on a varient of Debian that does not have the root account enabled by default, run the following:
1. sudo passwd root
  - Enter and confirm new root passwords.  The terminal will not show the characters as you are typing them.
2. su root
  - Enter the password you just created.
3. Congrats!  You are now running as root!


## Installation procedure:

1.  Switch to the root user, then clone the git repository.

![clone repository by using the git clone command](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/1-clone_repo.png "git clone example")
  - If you get an error about git not being a command, install git by using `apt-get install git`.
  
  ![](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/1.5-install_git.png "git not found")

2.  Once the repository has downloaded, cd into the ServerInstall directory.

![cd ServerInstall](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/2-cd_to_ServerInstall.png "cd example")

3.  Use chmod to give the execute (+x) permissions to the script.

![chmod +x ProPsync-srv-install.sh](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/3-allow_execute.png "Use chmod to grant execute permissions")

4.  Run the installation script.

![./ProPsync-srv-install.sh](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/4-run_script.png "Run the script using ./")

  - The script will take a minute to get through the initial steps.  During this time you will see applications downloading and updating.
  
5.  Once the script has finished the initial software installation, it will move to configuration.  Start by entering a username (with no spaces) to use with the ProPsync application.  This user should *not* already exist on the server.

![Enter a username with no spaces.](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/5-Enter_user.png "Example of username")

6.  Enter a password for the user twice.  Please note that you will not see any characters on the command line when you are typing the password.

![type the new password twice](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/6-confirm_passwords.png "Example of password prompt")

7.  Enter an IP address or URL to use with the cloud sync application.  By default, it will display your public IP.  Only use this if you plan to use the sync application outside of your internal network and do not plan on using a DNS name.  If you do want to use your public IP, simply press enter.  Whatever ip or dns name you use, the clients must be able to reach port 80 during setup (this can't change but only needs to be accessed during initial setup on the clients) and port 22 anytime they need to sync.  You can specify a different port after the IP or DNS name as long as that port forwards to port 22 on the server.

![type your URL](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/7-enter_url.png "Example of url prompt")

8.  Enter the storage root where you want to store all of the synced files or press enter to accept the default.  This directory should not exist yet.

![Enter your storage root](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/8-select_directory.png "Example of storage prompt")

9.  Once you have entered the storage root, you should see that the script initialized 3 empty Git repositories and it should state that installation completed.

![Setup completed](https://downloads.semrauconsulting.com/propsync/readme-images/srvinstall/9-confirmation_of_completion.png "Example of completion confirmation")