# Differential Gene Correlation Analysis (DGCA) Tool

## Brief Description
This tool is a command-line utility designed as a wrapper around the DGCA package, facilitating Differential Gene Correlation Analysis between two conditions. It is designed to identifying significant changes in gene correlation across different biological conditions, thus providing deeper understanding of gene regulatory dynamics and advanced biological insights .

## Reference
For detailed methodology and application, Please find the article here:
McKenzie, A.T., Katsyv, I., Song, WM. et al. DGCA: A comprehensive R package for Differential Gene Correlation Analysis. BMC System Biology, 106 (2016). https://bmcsystbiol.biomedcentral.com/articles/10.1186/s12918-016-0349-1.

## Installation Instructions

### Option 1: Docker Installation
To run the tool using Docker, ensure Docker is installed on your system and follow these steps:
1. Clone the repository:
   ```bash
   git clone git@github.com:bionetslab/grn-benchmark.git
   cd grn-benchmark/dgca-tool
   ```
2. Build the Docker image:
   ```bash
   docker build -t dgca-tool .
   ```
3. Run the tool using the Docker container:
   ```bash
   docker run --rm -v /<path_to_your_data>:/data dgca-tool --input_file_1 /data/condition1.tsv --input_file_2 /data/condition2.tsv --output_path /data
   ```

Replace <path_to_your_data> with the directory path where the datasets are kept.

### Option 2: Local Installation (Using R)
1. Clone the repository:
   ```bash
   git clone git@github.com:bionetslab/grn-benchmark.git
   cd grn-benchmark/dgca-tool
   ```
2. Install the required R packages:
   ```bash
   Rscript install_dependencies.R
   ```
3. Run the tool:
   ```bash
   Rscript dgca.R --input_file_1 <path_to_condition1_file> --input_file_2 <path_to_condition2_file> --output_path <output_directory>
   ```

## Instructions to execute the reference data
To run the tool, use the following command:
```bash
# 500 genes
Rscript dgca.R --input_file_1 ../../data/reference_datasets/500_genes/out_CD8_exhausted.tsv --input_file_2 ../../data/reference_datasets/500_genes/out_Macrophages.tsv -o ./

# 1000 genes
Rscript dgca.R --input_file_1 ../../reference_datasets/1000_genes/out_CD8_exhausted.tsv --input_file_2 ../../reference_datasets/1000_genes/out_Macrophages.tsv -o ./

# 2500 genes
Rscript dgca.R --input_file_1 ../../reference_datasets/2500_genes/out_CD8_exhausted.tsv --input_file_2 ../../reference_datasets/2500_genes/out_Macrophages.tsv -o ./

# Full Input
Rscript dgca.R --input_file_1 ../../reference_datasets/full_input/out_CD8_exhausted.tsv --input_file_2 ../../reference_datasets/full_input/out_Macrophages.tsv -o ./
```
Replace the paths with the actual locations of your input files and desired output directory.

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
