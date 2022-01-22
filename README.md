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

<DIV> Step 1 </DIV>
Download the raspberry pi imager from https://www.raspberrypi.com/software/ you will need this to install the operating System
<BR><BR>
<DIV> Step 2 </DIV>
a. Launch the imager and choose Raspberry PI OS LITE (32-BIT) for the operating system <BR>
<img src= "https://github.com/elhajj33/Thumbserve/blob/main/images/os.png?raw=true">  
b. Select your SD card <BR>
c. VERY IMPORTANT: Press Shift-CMD X (mac) or Shift-CTRL X (windows).  Be sure to add your wifi network password and your raspberry pi password.  This will allow you to login to your pi using SSH. <BR>
  



