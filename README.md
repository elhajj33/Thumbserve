# Thumbserve
RaspberryPi File share that will act as a thumb drive.  Useful for sending files to 3D printers and media devices

The intention of this project was to make a fat32 drive available for Resin 3D Printers able to only read fat 32 USB drives. 

## 
<div> HARDWARE </div>
This project was developed and tested using a RaspberryPi Zero 2 W. You can pick one fairly cheaply on amazon (see <a href="https://amzn.to/3nKTyhV"> link </a> if you don't already have a raspberrypi)
<br><br>
Important note: the installer will create an 8gb drive make sure you have at least a 16gb SD card
<br><br>
You will also need a data capable USB cable.  Many USB cables act only as charger cables; such cables will not work.  You will also need to modify the cable to prevent the rpi from backfeeding the printer LCD screen  it's a pretty simple mod of putting electrical tape on the power lead.  See below for the how it should look like:
<img src= "https://github.com/elhajj33/Thumbserve/blob/main/images/modifiedUSB.jpeg?raw=true">

##
<div> INSTALLATION </div>

<DIV> Step 1: Setup the RaspberryPi Image </DIV>
Download the raspberry pi imager from https://www.raspberrypi.com/software/ you will need this to install the operating System
<BR><BR>
<DIV> Step 2: Setup RaspberryPi Wifi and Password </DIV>
a. Launch the imager and choose Raspberry PI OS LITE (32-BIT) for the operating system <img src= "https://github.com/elhajj33/Thumbserve/blob/main/images/os.png?raw=true">  
b. Select your SD card 
c. VERY IMPORTANT: Press Shift-CMD X (mac) or Shift-CTRL X (windows).  Be sure to add your wifi network password and your raspberry pi password.  This will allow you to login to your pi using SSH. <img src= "https://github.com/elhajj33/Thumbserve/blob/main/images/settings.png?raw=true">
d.  Install the SD card in the rpi and boot it up
<BR><BR>
<DIV> Step 3: Software Installation </DIV>
a. SSH into the rpi using Putty or another utility.  For this you'll need to know the IP of your rPi.  You should be able to find this in your router. Everyone's network is different, so specific instructions can't be provided here. <br>
b. Once you are logged in, you will need to run the thumbserve.sh script. The image below shows the installation:
<img src= "https://github.com/elhajj33/Thumbserve/blob/main/images/install.png?raw=true">
c.  You'll need to execute these commands: <br>
  
  touch thumbserve.sh <br>
  sudo chmod 755 thumbserve.sh <br>
  nano thumbserve.sh <br>
  <br>
  Once you have nano open, just copy and paste the thumbserve.sh script into it and save the file
  <br>
  Next you'll need to execute thumbserve.sh.  Run it once and follow the instructions.  Run the script again after the first reboot and wait.  It will take some time to set everything up, but once complete, you can plug the rpi into your printer / media streamer etc.  You whould also see the share on your network to drop the files into.
   <br> <br>
 Feel free to ask any questions if you have issues
