#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/ini_files/zugspitze.ini -e 2024-04-02T11:00:00 -b 2023-10-01T00:00:00
