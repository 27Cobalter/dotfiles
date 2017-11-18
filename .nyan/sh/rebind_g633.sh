#!/bin/sh
busnum=`lsusb | grep Logitech | head -n 1 | sed "s/.*Bus 00\([0-9]*\) Device.*/\1/"`
portnum=`lsusb -t | grep Audio | head -n 1 | sed "s/.*Port \([0-9]*\):.*/\1/"`
if [ ! $busnum = "" -a ! $portnum = "" ] ; then
  sudo sh -c "echo -n '$busnum-$portnum' > /sys/bus/usb/drivers/usb/unbind"
  sudo sh -c "echo -n '$busnum-$portnum' > /sys/bus/usb/drivers/usb/bind"
  echo $busnum
  echo $portnum
fi
