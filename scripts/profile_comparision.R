# Install and load required packages
options(repos = "https://cran.r-project.org")

if (!requireNamespace("sarp.snowprofile.alignment", quietly = TRUE)) {
  install.packages("sarp.snowprofile.alignment")
}

library(sarp.snowprofile.alignment) # For aligning snow profiles
library(grid) # For visualizing in a PDF

# Set the working directory to the repository root for simpflied relative paths
setwd("../.")


# Following are the definitions of the comparisions of the snow profiles
# The comparisions are grouped by location and sorted by date

## Zugspitze
profiles_zugs_snowpack_initial <- list(
  titel = "Season Model Start",
  location = "Zugspitzplatt 2420m",
  date = "14.03.2024",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/zugspitze/snowpack_model_profiles/zugspitze_2024_03_14_snowpack_season.caaml'),
  reference_descr = "Hand Profile\n",
  reference = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_03_14.caaml')
)

profiles_zugs_snowpack_initial2 <- list(
  titel = "Season Model Start",
  location = "Zugspitzplatt 2420m",
  date = "14.03.2024",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/zugspitze/snowpack_model_profiles/zugspitze_2024_03_14_snowpack_season.caaml'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_03_14_density_snowpack_readin.caaml')
)

profiles_zugs_snowpack_processing <- list(
  titel = "Hand Profile Processing",
  location = "Zugspitzplatt 2420m",
  date = "14.03.2024",
  profile_descr = "SNOWPACK\nInitial Processing\nof hand profile",
  profile = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_03_14_density_snowpack_readin.caaml'),
  reference_descr = "Hand Profile\n",
  reference = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_03_14.caaml')
)

profiles_zugs_season <- list(
  titel = "Season Model",
  location = "Zugspitzplatt 2420m",
  date = "02.04.2024",
  profile_descr = "SNOWPACK Season Model",
  profile = snowprofileCaaml('data/snow_profiles/zugspitze/snowpack_model_profiles/zugspitze_2024_04_02_model.caaml'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_04_02_density_snowpack_readin.caaml')
)

profiles_zugs_hand <- list(
  titel = "Hand Model",
  location = "Zugspitzplatt 2420m",
  date = "02.04.2024",
  profile_descr = "SNOWPACK Model\nbased on hand profile\nfrom 14.03.2024",
  profile = snowprofileCaaml('data/snow_profiles/zugspitze/snowpack_model_profiles/zugspitze_2024_04_02_model_based_on_hand_2024_03_14.caaml'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/zugspitze/hand_profiles/zugspitze_2024_04_02_density_snowpack_readin.caaml')
)


## Kühroint
profiles_kueh_initial <- list(
  titel = "Season Model Start",
  location = "Kührointalm 1420m",
  date = "21.02.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/kuehroint/snowpack_model_profiles/kuehroint_2018_02_21_model.caaml'), 
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "Hand Profile",
  reference = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_21.caaml')
)

profiles_kueh_initial2 <- list(
  titel = "Season Model Start",
  location = "Kührointalm 1420m",
  date = "21.02.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/kuehroint/snowpack_model_profiles/kuehroint_2018_02_21_model.caaml'), 
  # Reference hand profile after adjusting grain size and  after SNOWPACK read-in
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_21_adjusted_snowpack_readin.caaml'), 
  notes = "Adjusted the grainsize from 5mm to 0.5mm"
)

profiles_kueh_snowpack_processing <- list(
  titel = "Hand Profile Processing",
  location = "Kührointalm 1420m",
  date = "21.02.2018",
  profile_descr = "SNOWPACK\nProcessing\nof hand profile",
  profile = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_21_adjusted_snowpack_readin.caaml'),
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "Hand Profile",
  reference = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_21.caaml')
)

profiles_kueh_season <- list(
  titel = "Season Model",
  location = "Kührointalm 1420m",
  date = "28.02.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/kuehroint/snowpack_model_profiles/kuehroint_2018_02_28_model.caaml'), 
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_28_snowpack_readin.caaml') 
)

profiles_kueh_hand <- list(
  titel = "Hand Model",
  location = "Kührointalm 1420m",
  date = "28.02.2018",
  profile_descr = "SNOWPACK Model\nbased on hand profile\nfrom 21.02.2018",
  profile = snowprofileCaaml('data/snow_profiles/kuehroint/snowpack_model_profiles/kuehroint_2018_02_28_based_on_hand_2018_02_21.caaml'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/kuehroint/hand_profiles/kuehroint_2018_02_28_snowpack_readin.caaml') 
)


## Pürschling
profiles_puer_initial <- list(
  titel = "Season Model Start",
  location = "Pürschling 1566m",
  date = "23.02.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_02_23_model.caaml'),# sourceType = 'modeled'),
  # Reference hand profile
  reference_descr = "Hand Profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_02_23.caaml') 
)

profiles_puer_initial2 <- list(
  titel = "Season Model Start",
  location = "Pürschling 1566m",
  date = "23.02.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_02_23_model.caaml'),# sourceType = 'modeled'),
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "SNOWPACK\nInitial Processing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_02_23_density_snowpack_readin.caaml') 
)

profiles_puer_snowpack_processing <- list(
  titel = "Hand Profile Processing",
  location = "Pürschling 1566m",
  date = "23.02.2018",
  profile_descr = "SNOWPACK Initial Processing\nof hand profile",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_02_23_density_snowpack_readin.caaml'),# sourceType = 'modeled'),
  # Reference hand profile
  reference_descr = "Hand Profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_02_23.caaml') 
)

profiles_puer_2weeks_season <- list(
  titel = "Season Model",
  location = "Pürschling 1566m",
  date = "07.03.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_03_07_model.caaml'),# sourceType = 'modeled'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_03_07_density_snowpack_readin.caaml') 
)

profiles_puer_2weeks_hand <- list(
  titel = "Hand Model",
  location = "Pürschling 1566m",
  date = "07.03.2018",
  profile_descr = "SNOWPACK Model\nbased on hand profile\nfrom 23.02.2018",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_03_07_based_on_hand_2018_02_23.caaml'),# sourceType = 'modeled'),
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_03_07_density_snowpack_readin.caaml') 
)

profiles_puer_4weeks_season <- list(
  titel = "Season Model",
  location = "Pürschling 1566m",
  date = "28.03.2018",
  profile_descr = "SNOWPACK\nSeason Model",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_03_28_model.caaml'),# sourceType = 'modeled'),
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_03_28_density_snowpack_readin.caaml') 
)

profiles_puer_4weeks_hand <- list(
  titel = "Hand Model",
  location = "Pürschling 1566m",
  date = "28.03.2018",
  profile_descr = "SNOWPACK Model\nbased on hand profile\nfrom 23.02.2018",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_03_28_based_on_hand_2018_02_23.caaml'),# sourceType = 'modeled'),
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_03_28_density_snowpack_readin.caaml') 
)

profiles_puer_2weeks_march_hand <- list(
  titel = "Hand Model",
  location = "Pürschling 1566m",
  date = "28.03.2018",
  profile_descr = "SNOWPACK Model\nbased on hand profile\nfrom 07.03.2018",
  profile = snowprofileCaaml('data/snow_profiles/puerschling/snowpack_model_profiles/puerschling_2018_03_28_based_on_hand_2018_03_07.caaml'),# sourceType = 'modeled'),
  # Reference hand profile after SNOWPACK read-in
  reference_descr = "SNOWPACK\nProcessing\nof hand profile",
  reference = snowprofileCaaml('data/snow_profiles/puerschling/hand_profiles/puerschling_2018_03_28_density_snowpack_readin.caaml') 
)

compared_locations <- list(
  profiles_zugs_snowpack_initial,
  profiles_zugs_snowpack_initial2,
  profiles_zugs_snowpack_processing,
  profiles_zugs_season,
  profiles_zugs_hand,
  profiles_kueh_initial,
  profiles_kueh_initial2,
  profiles_kueh_snowpack_processing,
  profiles_kueh_season,
  profiles_kueh_hand,
  profiles_puer_initial,
  profiles_puer_initial2,
  profiles_puer_snowpack_processing,
  profiles_puer_2weeks_season,
  profiles_puer_2weeks_hand,
  profiles_puer_2weeks_march_season,
  profiles_puer_2weeks_march_hand,
  profiles_puer_4weeks_season,
  profiles_puer_4weeks_hand
)

# Initialize an empty DataFrame
df <- data.frame(Location = character(),
                 Date = character(),
                 Profile_descr = character(),
                 Reference_descr = character(),
                 Similarity = numeric(),
                 Notes = character(),
                 stringsAsFactors = FALSE)

# Initialize an empty list to store r
results <- list()

# To plot the alignment - specify output file
pdf("results/combined_plot.pdf")
# Set up the plotting layout and outer margins
#par(oma = c(2, 2, 2, 2), mgp = c(3, 1, 0))  # Adjust outer margin values as needed
cex <- 1  # Set the font size

for (current_location in seq_along(compared_locations)) {
  analyzed_profiles <- compared_locations[[current_location]]

  # Align the profiles
  alignment <- dtwSP(query = analyzed_profiles$profile, ref = analyzed_profiles$reference, rescale2refHS = TRUE)
  
  # Store results
  if (!"notes" %in% names(analyzed_profiles)) {
    analyzed_profiles$notes <- ""
  }
  current_df <- data.frame(Location = analyzed_profiles$location,
                          Date = analyzed_profiles$date,
                          Profile_descr = analyzed_profiles$profile_descr,
                          Reference_descr = analyzed_profiles$reference_descr,
                          Similarity = alignment$sim,
                          Notes = analyzed_profiles$notes,
                          stringsAsFactors = FALSE)
  # Append the current DataFrame to the main DataFrame
  df <- rbind(df, current_df)

  # Plot the alignment
  # Set Margins
  par(mar = c(5, 4, 4, 8))  
  par(oma = c(0, 0, 6, 0))
  # Plot the first alignment
  plotSPalignment(dtwAlignment = alignment, mainQu = '', mainRef = '', mainQwarped = '', cex = cex)#, plot.costDensity = TRUE)
  # Provide an overall heading for the plot
  mtext(analyzed_profiles$titel, side = 3, line = 7, cex = 1.5, at = 0.6)
  mtext(paste(analyzed_profiles$location, "at", analyzed_profiles$date, sep = ' ') , side = 3, line = 6, cex = 1, at = 0.6)
  # Add sub-headings
  sub_heading_positions <- c(0.1, 0.6, 1.1) # Calculate positions for sub-headings
  mtext(analyzed_profiles$profile_descr, side = 3, line = 2, at = sub_heading_positions[1], cex = 1)
  mtext(analyzed_profiles$reference_descr, side = 3, line = 2, at = sub_heading_positions[2], cex = 1)
  mtext('Warped\nprofiles', side = 3, line = 3, at = sub_heading_positions[3], cex = 1)
}


# Export Dataframe as Markdown Tabel
# Install and load the knitr package
if (!requireNamespace("knitr", quietly = TRUE)) {
  install.packages("knitr")
}
library(knitr)

# Prepare Dataframe for print
replace_newlines <- function(text) {
  gsub("\n", " ", text)
}

# Apply the function to every field in the data frame
df[] <- lapply(df, function(column) {
  if (is.character(column)) {
    return(sapply(column, replace_newlines))
  } else {
    return(column)
  }
})

# Create a markdown table from the DataFrame
markdown_table <- kable(df, format = "markdown")

# Write the markdown table to a file
writeLines(markdown_table, "output.md")

