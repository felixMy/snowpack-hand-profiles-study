#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/inif_files/zugspitze_hand_profile.ini -e 2024-04-02T11:00:00 -b 2024-03-14T11:00:00
#snowpack -c data/inif_files/zugspitze_hand_profile.ini -e 2024-04-02T13:00:00 -b 2024-04-02T11:00:00
