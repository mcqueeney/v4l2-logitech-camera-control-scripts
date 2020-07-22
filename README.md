# V4L2 Logitech Webcam Scripts

This is a project with simple Bash shell convenience scripts to set and control
a Logitech web camera. 
Specifically, I wrote these scripts to control an HD Pro Webcam C920.

## Introduction 

In general,
all scripts will return the camera's current setting when called with no argument.
Otherwise,
the scripts accept one argument to use as the new camera setting.
The argument "sane" tells the script to set the camera control setting to a 
"reasonable" default, 
which is really just a way to say that default works for me in most settings.
Those "sane" default values are hard-coded at the top of each script to make them easily changeable.

Scripts are available to get and set the camera's:

* Exposure
* Focus
* Panning left and right
* Saturation
* White balance
* Zoom

If you have a different camera,
you probably can adapt these scripts to suit your needs.
All scripts currently are hard-coded to set the camera at /dev/video0.
You'll need to edit the scripts for a camera on a different device.

## Scripts

List of the shell scripts with guides on how to use them.

### csexp.sh  

Gets and sets the camera's exposure level.
When queried with v4l2-ctl -L, 
the Logitech C920 reports that the exposure values can be set to a minimum of 3,
a maximum of 2047,
with adjustments in steps of 1.
In reality,
the Logitech C920's exposure settings basically double starting at 77.
Because of this,
this script accepts special arguments of "up" and "down" to adjust the 
current exposure setting to the next major step supported by the camera.

### csfocus.sh

Gets and sets the camera's absolute focus value.
The Logitech C920 supports adjustments in steps of 5,
but you can pass it any integer value and the camera will set the focus 
to the nearest value you give it.

### cspan.sh

Gets and sets the camera's panning level.
The Logitech C920 supports panning levels from 
-36000 (the farthest left possible) to 36000 (the farthest right possible)
with increments of 3600.
To make dealing with these levels easier,
you can pass this script the followign special arguments:

* "Left": pan the farthest to the left as possible (-36000)
* "Right": pan the farthest to the right as possible (36000)
* "left": pan left to the next incremental level
* "right": pan right to the next incremental level

You need to be zoomed-in in order to pan the image.
(That is, 
this camera doesn't have a motor that actually moves the camera.)

### csreset.sh

Set all camera controls to their "sane" default values.
This is a convenience script that merely calls each of the other scripts 
with the "sane" argument.

### cssat.sh

Gets and sets the saturation level.
The Logitech C920 supports values of 0 to 255.

### cswb.sh

Gets and sets the camera's white balance temperature.
The Logitech C920 supports values from 2000 to 6500.

This script is a little different than the others because it accepts 
the argument "auto" to tell the camera to automatically set the white balance temperature.

### cszoom.sh

Gets and sets the camera's zoom level.
The Logitech C920 can zoom from 100 to 500,
with 100 meaning the image is used at 100% and not actually zoomed.
