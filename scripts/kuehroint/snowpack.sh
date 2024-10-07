#!/bin/bash

# Create the "output" directory
mkdir -p output

# Execute the command "snowpack"
snowpack -c data/ini_files/kuehroint_aws.ini -e 2018-02-28T10:30:00 -b 2017-10-01T00:00:00
