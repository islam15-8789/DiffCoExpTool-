## Overview

**DiffCorrTool** is a command-line interface built on the DGCA (Differential Gene Correlation Analysis) R package, designed to facilitate the exploration of differential gene co-expression across two distinct biological conditions. Drawing on the robust methodologies described in the DGCA: A comprehensive R package for Differential Gene Correlation Analysis[1].

If you find this tool useful in your research, please cite this publication.


## Features

- **Input:** Two TSV files containing gene expression data for two conditions.
- **Output:** A TSV file containing the differential correlation network.

## How to Use

### Clone the repository and navigate to the directory

```bash
git clone git@github.com:islam15-8789/diff-corr-tool.git \
&& cd diff-corr-tool
```

### 1. Running the Tool with Docker

You can use Docker to easily run this tool without worrying about dependencies.

#### Build the Docker Image

```bash
docker build -t diffcorr-tool .
```

#### Run the Docker Container

```bash
docker run -v /path/to/data:/data diffcorr-tool --input_file_1 /data/input1.tsv --input_file_2 /data/input2.tsv --output_path /data
```

Replace `/path/to/data` with the directory containing your input files and where you want the output to be saved.

### 2. Running the Tool Directly in R

Dependencies: R packages `dplyr`, `readr`, `tidyr`, `DGCA`, `optparse`.
Ensure you have the necessary R packages installed. You can run the tool directly in R with the following command:

```bash
Rscript diffcorr.R --input_file_1 path/to/input1.tsv --input_file_2 path/to/input2.tsv --output_path path/to/output
```

### Input file format specification:
- `--input_file_1`: Path to tab-separated file that contains the gene expression dataframe for condition 1:
    - Rows correspond to gene names and columns to cells 
    - First column is named **Gene** and contains the gene names
    - Each entry is a normalized gene expression value
- `--input_file_2`: Path to tab-separated file that contains the gene expression dataframe for condition 2:
    - Rows correspond to gene names and columns to cells 
    - First column is named **Gene** and contains the gene names
    - Each entry is a normalized gene expression value
- `--output_path`: String that contains the path to the output folder. Has to exist at time of execution.

### Output File

The output file `network.tsv` contains the differential correlation results with the following columns:

- **Target:** The first gene.
- **Regulator:** The second gene.
- **Condition:** The condition (either `condition1_cor` or `condition2_cor`).
- **Weight:** The correlation value.

## Interpretation of the output

- The nodes correspond to the genes.
- Each edge represents diff correlation between a pair of genes in either condition 1 or condition 2.


### Execution instructions using example data

I have provided two reference datasets from the paper[2], consisting of two input files, `BRCA_normal.tsv` and `BRCA_tumor.tsv`. The dataset contains 2,000 genes and 113 samples from the TCGA database. Additionally, both of the datasets are prepossed and normalized. To run the tool using this dataset, use the following command:

```bash
docker run -v ./data:/data diffcorr-tool --input_file_1 /data/BRCA_normal.tsv --input_file_2 /data/BRCA_tumor.tsv --output_path /data
```

### References

1. [Andrew T. McKenzie, et al, DGCA: A comprehensive R package for Differential Gene Correlation Analysis](https://bmcsystbiol.biomedcentral.com/articles/10.1186/s12918-016-0349-1)
2.[Sumanta Ray, et al, CODC: a Copula-based model to identify differential coexpression](https://www.nature.com/articles/s41540-020-0137-9)