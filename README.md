Here's a revised `README.md` for the DGCA tool that incorporates a collapsible Table of Contents and organizes the content in a manner similar to your CODC project README:

```markdown
# Differential Gene Correlation Analysis (DGCA) Tool

<details>
<summary>Table of Contents</summary>

- [Brief Description](#brief-description)
- [Reference](#reference)
- [Installation Instructions](#installation-instructions)
  - [Using Docker](#using-docker)
  - [Using Locally](#using-locally)
- [Parameters](#parameters)
- [Input File Format](#input-file-format)
- [Output File Format](#output-file-format)
- [Contributing](#contributing)
- [License](#license)

</details>

## Brief Description
This tool is a command-line utility designed as a wrapper around the DGCA package, facilitating Differential Gene Correlation Analysis between two conditions. It aids in identifying significant changes in gene correlation across different biological conditions, supporting advanced biological insights into gene regulatory mechanisms.

## Reference
For detailed methodology and application, please refer to:
McKenzie, A.T., Katsyv, I., Song, WM. et al. DGCA: A comprehensive R package for Differential Gene Correlation Analysis. BMC Syst Biol 10, 106 (2016). [https://doi.org/10.1186/s12918-016-0349-1](https://doi.org/10.1186/s12918-016-0349-1).

## Available Commands
The CLI includes commands for:
- Differential Correlation Analysis (dgca.R)
- [Enrichment Map (enrichmentmap.R)](downstream-analysis/enrichment-map.md)

In this readme, we will see the usage of dgca.R

## Installation Instructions

### Using Docker
To run the tool using Docker, ensure Docker is installed on your system and follow these steps:

1. Navigate to the project (dgca-tool) root directory.

2. Build the Docker image:
   ```bash
   docker build -t dgca-tool .
   ```
3. Run the tool using the Docker container:
   ```bash
   docker run --rm -v ./data:/data dgca-tool dgca.R --input_file_1 /data/BRCA_normal.tsv --input_file_2 /data/BRCA_tumor.tsv --output_path /data
   ```

### Using Locally (Using R)
1. Navigate to the project (dgca-tool) root directory.

2. Install the required R packages:
   ```bash
   Rscript install_dependencies.R
   ```
3. Run the tool:
   ```bash
   Rscript dgca.R --input_file_1 /data/BRCA_normal.tsv --input_file_2 /data/BRCA_tumor.tsv --output_path ./data
   ```

## Parameters
- `--input_file_1`: Path to the TSV file containing gene expression data for the first condition.
- `--input_file_2`: Path to the TSV file containing gene expression data for the second condition.
- `--output_path`: Output path where the results will be saved. The results file will be named 'network.tsv'.

## Input File Format
The input files should be TSV (Tab-Separated Values) format containing gene expression data. Each file must have genes as rows and samples as columns for each condition.

## Output File Format
| Target  | Regulator | Condition    | Weight_1      | Weight_2   | Weight_3     | Weight_4     | Weight_5 |
|---------|-----------|--------------|---------------|------------|--------------|--------------|----------|
| CACYBP  | NACA      | condition1   | -0.070261455  | 0.67509118 | 1.100991e-24 | 1.100991e-24 | 0/+      |
| CACYBP  | NACA      | condition2   | 0.9567267     | 0          | 1.100991e-24 | 1.100991e-24 | 0/+      |

**Column Descriptions:**
- **Target**: Target node of the edge.
- **Regulator**: Source node of the edge.
- **Weight_1**: Correlation coefficient of the gene pair for the specified condition.
- **Weight_2**: p-value of the correlation for the specified condition.
- **Weight_3**: z-Score difference between the two conditions.
- **Weight_4**: p-value of the z-Score difference.
- **Weight_5**: Classification of the correlation change.