# stratified_sampling.R
# ---------------------------------------------------------
# This script compares simple random sampling and stratified sampling
# using demographic data. It demonstrates proportional sampling by gender
# and compares population vs sample mean heights.
# Author: Dzivhani D | Year: 2025
# ---------------------------------------------------------

# Load the demographic dataset
Demographic <- read.csv("Demographic.csv", header = TRUE)

# Proportions of gender in the population
gender_props <- prop.table(table(Demographic$gender))
gender_props

# --- SIMPLE RANDOM SAMPLE (n = 80) ---
set.seed(42)  # for reproducibility
srs_indices <- sort(sample(nrow(Demographic), 80, replace = FALSE))
DEMOsrs_set <- Demographic[srs_indices, ]

# Gender distribution in SRS
srs_gender_props <- prop.table(table(DEMOsrs_set$gender))
srs_gender_props

# --- STRATIFIED SAMPLE (proportional to gender) ---
strat_sizes <- round(80 * gender_props)  # Sample size per gender group

# Separate the population by gender
male_group <- Demographic[Demographic$gender == "M", ]
female_group <- Demographic[Demographic$gender == "F", ]

# Sample from each gender group
strat_male <- male_group[sort(sample(nrow(male_group), strat_sizes["M"])), ]
strat_female <- female_group[sort(sample(nrow(female_group), strat_sizes["F"])), ]

# Combine into one stratified sample
DEMOstrat_set <- rbind(strat_male, strat_female)
table(DEMOstrat_set$gender)

# --- MEAN COMPARISON: height ---
pop_mean_height <- mean(Demographic$height)
srs_mean_height <- mean(DEMOsrs_set$height)
strat_mean_height <- mean(DEMOstrat_set$height)

# Print results
cat("Population Mean Height:", round(pop_mean_height, 2), "\n")
cat("SRS Mean Height:", round(srs_mean_height, 2), "\n")
cat("Stratified Mean Height:", round(strat_mean_height, 2), "\n")

# Summary:
# - SRS may not reflect true gender proportions
# - Stratified sampling ensures proportional representation
# - This often yields more accurate estimates for subgroup-based variables
