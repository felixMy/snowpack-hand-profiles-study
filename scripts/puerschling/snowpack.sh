#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/ini_files/puerschling_aws.ini -e 2018-03-28T12:00:00 -b 2017-10-01T00:00:00
