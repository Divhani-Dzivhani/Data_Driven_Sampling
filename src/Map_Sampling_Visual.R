# map_sampling_visual.R
# ---------------------------------------------------------
# This script demonstrates systematic vs simple random sampling
# on a path-ordered dataset of ABQ locations. It visualizes both
# sampling techniques on a coordinate map.
# Author: Dzivhani D | Year: 2025
# ---------------------------------------------------------

# Load the data files
ABQ <- read.csv("ABQ.csv", header = TRUE)
ABQcoord <- read.csv("ABQcoord.csv", header = TRUE)

# Order the data by path to simulate a real-world route
ABQ_ordered <- ABQ[order(ABQ$path), ]

# Plot the base map of ABQ locations
plot(ABQ$Lattitude, ABQ$Longitude,
     main = "ABQ Path Map", xlab = "Latitude", ylab = "Longitude")

# Add labels for path order and area names
text(ABQ$Lattitude, ABQ$Longitude, labels = ABQ$path, pos = 3, cex = 0.6)
text(ABQcoord$Lattitude, ABQcoord$Longitude,
     labels = ABQcoord$Name, col = "blue", pos = 1, cex = 0.5)

# Connect the ordered path with red lines
lines(ABQ_ordered$Lattitude, ABQ_ordered$Longitude, col = "red")

# --- SYSTEMATIC SAMPLE (n=5) ---
k <- 6  # population size = 30, n = 5 --> k = 6
start <- sample(1:k, 1)  # random start between 1 and k
sys_indices <- seq(start, by = k, length.out = 5)
sys_sample <- ABQ_ordered[sys_indices, ]

# Plot the systematic sample (green dots)
points(sys_sample$Lattitude, sys_sample$Longitude, col = "green", pch = 20, cex = 1.5)

# --- SIMPLE RANDOM SAMPLE (n=5) ---
srs_indices <- sort(sample(nrow(ABQ_ordered), 5, replace = FALSE))
srs_sample <- ABQ_ordered[srs_indices, ]

# Plot the SRS (purple stars)
points(srs_sample$Lattitude, srs_sample$Longitude, col = "purple", pch = 8, cex = 1.5)

# Summary:
# - Systematic sampling spreads evenly along the path
# - SRS can cluster or overlap with systematic points
# - Both are useful depending on field study goals
