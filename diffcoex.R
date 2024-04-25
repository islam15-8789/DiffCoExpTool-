#!/usr/bin/env Rscript

# Load necessary libraries
suppressPackageStartupMessages({
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
  }
  library(dplyr)
  
  if (!requireNamespace("readr", quietly = TRUE)) {
    install.packages("readr")
  }
  library(readr)
  
  if (!requireNamespace("DGCA", quietly = TRUE)) {
    if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
    }
    BiocManager::install("DGCA")
  }
  library(DGCA)
  
  if (!requireNamespace("optparse", quietly = TRUE)) {
    install.packages("optparse")
  }
  library(optparse)
})

# Define command line options
option_list <- list(
  make_option(c("--input_file_1"), type = "character", default = "", help = "Path to the TSV file containing gene expression data for the first condition (e.g., normal).", metavar = "FILE"),
  make_option(c("--input_file_2"), type = "character", default = "", help = "Path to the TSV file containing gene expression data for the second condition (e.g., cancer).", metavar = "FILE"),
  make_option(c("--output_path"), type = "character", default = "", help = "Output path where the results will be saved. The results file will be named 'network.tsv'.", metavar = "DIR")
)

parser <- OptionParser(option_list = option_list)
args <- parse_args(parser)

# Ensure all required arguments are provided
if (args$input_file_1 == "" || args$input_file_2 == "" || args$output_path == "") {
  print_help(parser)
  stop("Missing arguments. Please specify all required files and output path.", call. = FALSE)
}

# Load the datasets using correct paths
input_1 <- read_tsv(args$input_file_1)
input_2 <- read_tsv(args$input_file_2)

# Convert tibbles to data frames and set row names
input_1 <- as.data.frame(input_1)
rownames(input_1) <- input_1$Gene
input_1 <- input_1[,-1]

input_2 <- as.data.frame(input_2)
rownames(input_2) <- input_2$Gene
input_2 <- input_2[,-1]

# Ensure that both datasets have the same genes in the same order
all_genes <- intersect(rownames(input_1), rownames(input_2))
input_1 <- input_1[all_genes,]
input_2 <- input_2[all_genes,]

# Combine the two datasets
combined_data <- cbind(input_1, input_2)

# Create the design matrix
condition <- c(rep("condition1", ncol(input_1)), rep("condition2", ncol(input_2)))
design_matrix <- model.matrix(~ 0 + condition)
colnames(design_matrix) <- c("condition1", "condition2")

# Perform differential correlation analysis
ddcor_results <- ddcorAll(inputMat = combined_data, design = design_matrix, compare = c("condition1", "condition2"))

# Transform ddcor_results to match the desired output format
formatted_results <- ddcor_results %>%
  select(Gene1, Gene2, condition1_cor, condition1_pVal, condition2_cor, condition2_pVal) %>%
  mutate(
    target = Gene1,
    regulator = Gene2,
    condition = paste("condition1"),
    weight = condition1_cor
  ) %>%
  select(target, regulator, condition, weight)

# Save the reformatted results as a TSV file
output_file_path <- file.path(args$output_path, "network.tsv")
write_tsv(formatted_results, output_file_path)

# Print path to output file
cat("Results saved to:", output_file_path, "\n")
