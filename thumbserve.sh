#!/usr/bin/env bash

# filename: thumbserve.sh 
# Modified from Ocot Chituboard project to implement only USB and Samba install

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

if ! [ "$(id -u)" = 0 ]; then
    warn "This script needs to be run as root." >&2
    exit 1
fi

# check if the reboot flag file exists. 
# We created this file before rebooting.
if [ ! -f ./resume-thumbserve ]; then
    warn "Running script for the first time.."
    
    # run your scripts here
    info
    info "Welcome to ThumbServe Installer!"
    sleep .1
    info "..."

    sleep 1

    i=0
    read -r -p "Enter network share name.  Name MUST be one word comprised of alphanumeric characters only: "  hostname
    while [ $i -eq 0 ]
    do
        if [[ "$hostname" =~ [^a-zA-Z0-9] ]]; then
            echo "Network share name is invalid, please re-enter"
        else
            ((i++))
        fi
    done

    sudo sed -i "/raspberrypi/c $hostname" /etc/hostname
    sudo sed -i "/127.0.1.1		raspberrypi/c 127.0.1.1		 $hostname" /etc/hosts
  
    sleep 1

    warn "It is a good idea to change your password from the default"
    while true
    do
        read -r -p "Change now? [Y/n] " input
    
        case $input in
            [yY][eE][sS]|[yY])
        info
        echo "$(passwd pi)"
        break
        ;;
            [nN][oO]|[nN])
        break
                ;;
            *)
        warn "Invalid input..."
        esac
    done

    # create a flag file to check if we are resuming from reboot.
    sudo touch ./resume-thumbserve

    info "rebooting.."
    # reboot here
    sudo reboot
    sleep 5

else 
    warn "Resuming script after reboot.."
    
    # remove the temporary file that we created to check for reboot
    sudo rm -f ./resume-thumbserve
    # continue with rest of the script

    info "Running apt update"
    sudo apt-get update

    # setup 8 GB container file to for storing uploaded files
    info
    info "Setting up 8GB USB; this could take several minutes"
    echo "dtoverlay=dwc2,dr_mode=peripheral" >> /boot/config.txt
    echo -n " modules-load=dwc2" >> /boot/cmdline.txt
    sudo dd bs=1M if=/dev/zero of=/piusb.bin count=8192
    sudo mkdosfs /piusb.bin -F 32 -I
    # Create the mount point for the container file
    sudo mkdir /home/pi/.thumbserve
    sudo mkdir /home/pi/.thumbserve/uploads
    echo "/piusb.bin            /home/pi/.thumbserve/uploads  vfat    users,uid=pi,gid=pi,umask=000   0       2 " >> /etc/fstab

    sudo mount -a

    sudo sed -i 's/exit 0//g' /etc/rc.local

    echo '
    /bin/sleep 5
    modprobe g_mass_storage file=/piusb.bin removable=1 ro=0 stall=0
    exit 0' >> /etc/rc.local

    sudo systemctl stop serial-getty@ttyS0
    sudo systemctl disable serial-getty@ttyS0

    info ""
    info "Setting up Network share; this could take a long time"

    sudo apt-get -y install samba winbind -y

    echo "[Files]
    comment = Files
    path = /home/pi/.thumbserve/uploads
    browseable = Yes
    writeable = Yes
    only guest = no
    create mask = 0777
    directory mask = 0777
    public = yes
    read only = no
    force user = root
    force group = root" >> /etc/samba/smb.conf

    info ""

    sudo sed -i "/workgroup = WORKGROUP/a\   mdns name=mdns" /etc/samba/smb.conf

    while true
    do
        read -r -p "Reboot now? [Y/n] " input
    
        case $input in
            [yY][eE][sS]|[yY])
        warn "Rebooting in 5 seconds"
        sleep 5
        echo "$(sudo reboot)"
        break
        ;;
            [nN][oO]|[nN])
        break
                ;;
            *)
        warn "Invalid input..."
        esac
    done
fi
