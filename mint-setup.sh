#!/bin/bash

# mint-setup.sh
# 
# The purpose of this script is to call other github/chaslinux scripts we use to deploy a user-friendly
# version of Linux Mint, complete with extra software we think will be handy to end users, as well as
# a script to detect the system's hardware, and run a couple of benchmarks: geekbench6, and yaquake2.
#
# NOTE: do not run this script with sudo, but you should be a user with sudo access, it will prompt you
# for your password in order to install software.
# 
# In other words, just enter the directory this file is in and type: ./mint-setup.sh
#
# by chaslinux@gmail.com
# Licensed under GPL v3

GINSTALL=$(which git)


## first run all updates
sudo apt update && sudo apt upgrade -y

# Check if git is installed, if not, install git
if [ -z "$GINSTALL" ];
    then
        echo "*** Installing git ***"
        sudo apt install git -y
fi

# make the code directory and change into it
mkdir ~/Code
cd ~/Code

# clone the git repositories we use
git clone https://github.com/chaslinux/hardware.sh
git clone https://github.com/hxasjc/mint-extras
# No need to do geekbench anymore using sysbench and glmark2 in hardware.sh to do benchmarking
# git clone https://github.com/chaslinux/geekbench-dl
git clone https://github.com/chaslinux/pts


# now run the hardware detection script, followed by the mint-extras (additional software), and
# then the CPU benchmark geekbench
cd ~/Code/hardware.sh
./hardware.sh
cd ~/Code/mint-extras
./mint-extras.sh

# Test removed from this script as we no longer run it as part of our process
# cd ~/Code/geekbench-dl
#./geekbench-dl.sh
# create a delay so the volunteer can follow the Geekbench URL and write down the results
# read -p "Follow the link above and write down the results. Press any key to start the game benchmark!" -n1 -s

# Install Phoronix-Test-Suite, but we're not using it anymore, it's still handy for some testing
cd ~/Code/pts
./phoronix.sh



