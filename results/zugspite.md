# Comparision Zugspitze 
- Similarity of Season Model with Reference:             0.484279
Similarity of Hand Profile based Model with Reference: 0.465593

## Changes & Settings
- The reference profile is taken as SNOWPACK read-in: A simulation was started with the same start date as the reference profile and the reference profile itself as initial profile. From this simulation the first generated profile from the PRO-File was extracted. 
- Simulations based on the hand-profile do NOT need to match the measured snow hight (`enforce_measured_snow_heights = FALSE`)
- Simulations based on the hand-profile have `CAAML_MAX_ELEMENT_THICKNESS` NOT set
- Comparison is done with the first generated profile from the PRO-File
- `rescale2refHS = TRUE`

## At 14.03.2024
- Similarity of Season Model with Reference:             0.461290

## At 02.04.2024
- Similarity of Season Model with Reference:             0.489771
- Similarity of Hand Profile based Model with Reference: 0.484879
