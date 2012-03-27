#!/bin/sh

##
# Bash script to control MSP430G2231 blink sample from beagle bone
#
# connect:
# 
# - GND  of MSP to P8.1 of BB
# - VCC  of MSP to P8.3 of BB
# - P1.3 of MSP to P8.4 of BB
##

setup() {

	echo "setup"

	# GPIO38+39 to OUTPUT, MODE7
	echo 7 > /sys/kernel/debug/omap_mux/gpmc_ad6
	echo 7 > /sys/kernel/debug/omap_mux/gpmc_ad7

	# Export GPIO38+39	
	echo 38 > /sys/class/gpio/export 	
	echo 39 > /sys/class/gpio/export 	

	# Set to output
	echo out > /sys/class/gpio/gpio38/direction
	echo out > /sys/class/gpio/gpio39/direction

	# Set value initially to 0
	echo 0 > /sys/class/gpio/gpio38/value
	echo 0 > /sys/class/gpio/gpio39/value
}

shutdown() {

	echo "Shutdown"

	# Unexport GPIO38+39	
	echo 38 > /sys/class/gpio/unexport 	
	echo 39 > /sys/class/gpio/unexport 	

	# GPIO38+39 to OUTPUT, MODE0
	#echo 0 > /sys/kernel/debug/omap_mux/gpmc_ad6
	#echo 0 > /sys/kernel/debug/omap_mux/gpmc_ad7
}

enable_power() {

	echo "enable_power=$1"
	echo $1 > /sys/class/gpio/gpio38/value
}

toggle_mode() {

	echo "toggle_mode"
	echo 1 > /sys/class/gpio/gpio39/value
	echo 0 > /sys/class/gpio/gpio39/value
}


setup
enable_power 1
sleep 5
toggle_mode
sleep 5
toggle_mode
sleep 5
enable_power 0
shutdown
