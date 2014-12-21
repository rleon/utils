#!/bin/sh
# This script is intended to set display according to 
# preset configuration.
# My setup includes one of the following setups:
# * Notebook display only, no external displays - LVDS1 connected.
# * Notebook display + one external display which presents the same 
#	output - LVDS1 connected and VGA1 or HDMI1 connected.
# * Two external displays - VGA1 and HDMI1 connected, LVDS1 is connected too but powered off.

export DISPLAY=:0
export XAUTHORITY=/home/leon/.Xauthority

NUMB_OF_DISPLAYS=$(xrandr -q | grep " connected" | awk '{print $1}' | wc -l)

case "$NUMB_OF_DISPLAYS" in
1) xrandr --output HDMI3 --off
   xrandr --output LVDS1 --mode 1600x900
   xrandr --output HDMI2 --off
   xrandr --output VGA1 --off
;;
2) xrandr --output VGA1 --auto
;;
3) xrandr --output VGA1 --off
   xrandr --output HDMI2 --mode 1920x1080
   xrandr --output LVDS1 --off
   xrandr --output HDMI3 --mode 1920x1080 --left-of HDMI2
   xrandr --output HDMI3 --primary
;;
esac
