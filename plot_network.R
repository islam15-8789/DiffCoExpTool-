#!/usr/bin/env Rscript

library(dplyr)
library(igraph)
library(readr)
library(optparse)

# Set up command-line argument parsing
option_list <- list(
  make_option(c("-f", "--file"), type = "character", default = "", help = "Path to the TSV file containing the network data", metavar = "file"),
  make_option(c("--threshold1"), type = "numeric", default = 0.0, help = "Absolute threshold for filtering weights in condition 1", metavar = "threshold1"),
  make_option(c("--threshold2"), type = "numeric", default = 0.0, help = "Absolute threshold for filtering weights in condition 2", metavar = "threshold2"),
  make_option(c("-o", "--output"), type = "character", default = "", help = "Output path to save the network images", metavar = "output")
)

# Parse options
args <- parse_args(OptionParser(option_list = option_list))

# Read data
data <- read_tsv(args$file) %>% na.omit()

# Separate data by condition without applying thresholds yet
data_condition1 <- data %>% filter(grepl("condition1", Condition)) %>% select(-Condition)
data_condition2 <- data %>% filter(grepl("condition2", Condition)) %>% select(-Condition)

# Calculate mean and median before applying thresholds
mean_condition1 <- mean(abs(data_condition1$Weight), na.rm = TRUE)
median_condition1 <- median(abs(data_condition1$Weight), na.rm = TRUE)
mean_condition2 <- mean(abs(data_condition2$Weight), na.rm = TRUE)
median_condition2 <- median(abs(data_condition2$Weight), na.rm = TRUE)

# Now apply thresholds
data_condition1 <- data_condition1 %>% filter(abs(Weight) >= args$threshold1)
data_condition2 <- data_condition2 %>% filter(abs(Weight) >= args$threshold2)

# Function to plot and save network with stats
plot_network <- function(data, output_path, main_title, threshold, mean_weight, median_weight) {
  g <- graph_from_data_frame(data, directed = FALSE)
  node_degrees <- degree(g)
  
  # Stats text includes statistics calculated before threshold application
  stats_text <- sprintf("Mean: %.2f, Median: %.2f, Applied Threshold: %.2f", mean_weight, median_weight, threshold)
  
  # Create PNG file
  png(filename = file.path(output_path, paste0(main_title, ".png")), width = 800, height = 800)
  plot(g, main = main_title,
       vertex.size = node_degrees * 2,
       vertex.label.cex = 0.8,
       vertex.color = "skyblue",
       edge.width = E(g)$weight * 8,
       layout = layout_with_kk(g))
  # Add stats text to the plot
  legend("bottom", legend = stats_text, bty = "n", cex = 1.5)
  dev.off()
}

# Execute plotting and saving for both conditions
plot_network(data_condition1, args$output, "Network for Condition 1", args$threshold1, mean_condition1, median_condition1)
plot_network(data_condition2, args$output, "Network for Condition 2", args$threshold2, mean_condition2, median_condition2)
