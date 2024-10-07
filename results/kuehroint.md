# Comparision Kührointalm 1420m
Changes & Settings:
- Grain size of the first two layers (new snow & decomposed snow) are reduzed to 0,5mm (originally 5mm and 1,5mm)
- The reference profile is taken as SNOWPACK read-in: A simulation was started with the same start date as the reference profile and the reference profile itself as initial profile. From this simulation the first generated profile from the PRO-File was extracted. 
- Simulations based on the hand-profile do NOT need to match the measured snow hight (`enforce_measured_snow_heights = FALSE`)
- Simulations based on the hand-profile have `CAAML_MAX_ELEMENT_THICKNESS` NOT set
- `rescale2refHS = TRUE`

## At 21.02.2018
Similarity of Season Model with Reference:             0.492861

## At 28.02.2018
Similarity of Season Model with Reference:             0.591507
Similarity of Hand Profile based Model with Reference: 0.401364

## At 28.02.2018 with adjustments on the hand profile from the 21.02.2018
- The grain size of the new snow and the decomposed snow was set to 0,5mm. (Originally 5mm and 1,5mm)
Similarity of Season Model with Reference:             0.591507
Similarity of Hand Profile based Model with Reference: 0.600725

