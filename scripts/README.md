# Scripts
This directory contains scripts used to generate the data and insights of the study. 

## SNOWPACK 
The commands to execute the SNOWPACK simulations are written in shell scripts. 
Grouped by the site, the scripts are named `snowpack.sh`. for a run with the puerly aws based model and `snowpack_hand_profile.sh` for a run with the hand profile based model. 

## Handprofile Preprocessing
Since SNOWPACK requires the density of the snow layers, `profile_preprocessing.py` is used to parameterize the density based on the grain type and hand hardness.

## Similarity Comparison
The various comparisons between the profiles are conducted in `profile_comparison.R`. The script reads the profiles from the `snow_profiles` directory and writes its results directly to the `results` directory.