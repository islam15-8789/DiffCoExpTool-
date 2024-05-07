## Overview

**DiffCoExpTool** is a command-line interface built on the DGCA (Differential Gene Correlation Analysis) R package, designed to facilitate the exploration of differential gene co-expression across two distinct biological conditions. Drawing on the robust methodologies described in the [DGCA paper](https://bmcsystbiol.biomedcentral.com/articles/10.1186/s12918-016-0349-1).

If you find this tool useful in your research, please cite this publication.


## Features

- **Input:** Two TSV files containing gene expression data for two conditions.
- **Output:** A TSV file containing the differential correlation network.

## How to Use

### Running the Tool with Docker

You can use Docker to easily run this tool without worrying about dependencies.

#### Build the Docker Image

```bash
docker build -t diffcor-tool .
```

#### Run the Docker Container

```bash
docker run -v /path/to/data:/data diffcor-tool --input_file_1 /data/input1.tsv --input_file_2 /data/input2.tsv --output_path /data
```

Replace `/path/to/data` with the directory containing your input files and where you want the output to be saved.

### Input Files

Each input file should be a TSV file with the following structure:

- The first column should be the gene names (header `Gene`).
- The other columns should be expression values for different samples.

### Output File

The output file `network.tsv` contains the differential correlation results with the following columns:

- **Target:** The first gene.
- **Regulator:** The second gene.
- **Condition:** The condition (either `condition1_cor` or `condition2_cor`).
- **Weight:** The correlation value.

### Example

Suppose you have two input files `normal.tsv` and `cancer.tsv` in the current directory. To run the tool, use the following command:

```bash
docker run -v /path/to/data:/data diffcor-tool --input_file_1 /data/normal.tsv --input_file_2 /data/cancer.tsv --output_path /data
```
