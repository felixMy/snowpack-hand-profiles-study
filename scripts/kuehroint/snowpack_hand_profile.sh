#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/ini_files/kuehroint_hand_profile.ini -e 2018-02-28T12:00:00 -b 2018-02-28T11:00:00
