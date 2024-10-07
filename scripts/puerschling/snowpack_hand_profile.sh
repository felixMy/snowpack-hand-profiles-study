#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/ini_files/puerschling_hand_profile.ini -e 2018-03-28T12:00:00 -b 2018-02-23T14:30:00
#snowpack -c data/ini_files/puerschling_hand_profile.ini -e 2018-03-28T11:00:00 -b 2018-03-07T11:00:00
#snowpack -c data/ini_files/puerschling_hand_profile.ini -e 2018-03-28T13:00:00 -b 2018-03-28T11:00:00
#snowpack -c data/ini_files/puerschling_hand_profile.ini -e 2018-03-07T13:00:00 -b 2018-03-07T11:00:00