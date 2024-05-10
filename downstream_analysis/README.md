# Enrichment Analysis Script

## Description
This script performs Gene Set Enrichment Analysis (GSEA) on provided network data to identify significant pathways related to differential gene correlations. The script can generate enrichment maps for combined data or for specific conditions, facilitating deeper insights into the biological significance of the observed correlations.

## Prerequisites
Before running this script, ensure that the following R packages are installed:
- `readr`
- `dplyr`
- `tidyr`
- `clusterProfiler`
- `enrichplot`
- `AnnotationDbi`
- `ggplot2`
- `optparse`
- `pbapply`

## Installation
You can install the required R packages using the following commands:
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("clusterProfiler", "enrichplot", "AnnotationDbi"))

install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "optparse", "pbapply"))
