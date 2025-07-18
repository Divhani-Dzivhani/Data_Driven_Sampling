# sampling_comparison.R
# ---------------------------------------------------------
# This script compares judgment sampling and simple random sampling
# using a dataset of rectangle areas. It visualizes differences
# using histograms and boxplots, and shows how sample means vary.
# Author: Dzivhani D | Year: 2025
# ---------------------------------------------------------

# Load required data
Rectangle <- read.csv("Rectangle.csv", header = TRUE)

# Select a judgment sample of 5 rectangles manually
judgment_indices <- c(18, 21, 52, 76, 80)
judgment_sample <- Rectangle[judgment_indices, ]
judgment_mean <- mean(judgment_sample$Area)

# Select a simple random sample of 5 rectangles
set.seed(123)  # for reproducibility
srs_indices <- sort(sample(nrow(Rectangle), 5, replace = FALSE))
srs_sample <- Rectangle[srs_indices, ]
srs_mean <- mean(srs_sample$Area)

# Load pre-collected class means from 49 students
RectangleMeans <- read.csv("RectangleMeans.csv", header = TRUE)

# Compare population mean to judgment and SRS sample means
population_mean <- mean(Rectangle$Area)
class_judgment_mean <- mean(RectangleMeans$judgement)
class_srs_mean <- mean(RectangleMeans$srs)

# Combine into a vector for plotting
all_means <- c(population_mean, class_judgment_mean, class_srs_mean)

# Set plot layout and margins
par(mfrow = c(2, 2))
par(mar = c(2, 2, 2, 2))

# Histogram of the full population
hist(Rectangle$Area, main = "Rectangle Size Distribution",
     col = "lightgray", cex.main = 0.8)

# Boxplot comparing population, judgment, and SRS means
boxplot(Rectangle$Area, RectangleMeans$judgement, RectangleMeans$srs,
        names = c("Population", "Judgment", "SRS"),
        main = "Boxplot: Population vs Samples",
        col = c("green", "red", "orange"),
        border = "brown", notch = TRUE)
points(all_means, pch = 20, cex = 1.5, col = "blue")
text(x = c(1, 2, 3), y = all_means + 1.5,
     labels = paste("Mean=", round(all_means, 2)), cex = 0.7)

# Histograms of sample means
hist(RectangleMeans$judgement, main = "Judgment Sample Means", col = "red", cex.main = 0.8)
hist(RectangleMeans$srs, main = "SRS Sample Means", col = "orange", cex.main = 0.8)

# Reset plot layout
dev.off()

# Summary Comments:
# - Judgment samples show more variability than SRS.
# - SRS means cluster more tightly around the true mean.
# - This highlights why SRS is statistically preferred in most cases.
