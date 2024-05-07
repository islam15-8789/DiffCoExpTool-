# Use an R base image with version 4.0.5 from Rocker
FROM --platform=linux/amd64 rocker/r-ver:4.0.5

# Set the maintainer label
LABEL maintainer="yourname@example.com"

# Install necessary Linux dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev && \
    apt-get clean

# Install Bioconductor manager
RUN R -e "if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')" && \
    R -e "BiocManager::install(c('WGCNA', 'impute', 'preprocessCore', 'minet', 'org.Mm.eg.db'))"

RUN R -e "stopifnot(require(WGCNA), require(impute), require(preprocessCore), require(minet), require(org.Mm.eg.db))"

# Install CRAN packages
RUN R -e "install.packages(c('dplyr', 'readr', 'optparse'), dependencies=TRUE)"

RUN R -e "stopifnot(require(dplyr), require(readr), require(optparse))"

# Install DGCA from CRAN archive
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/DGCA/DGCA_1.0.2.tar.gz', repos = NULL, type = 'source')"

# Verify package installations
RUN R -e "stopifnot(require(DGCA))"

# Copy the R script into the container
COPY diffcoex.R /usr/local/src/scripts/diffcoex.R

# Make the R script executable
RUN chmod +x /usr/local/src/scripts/diffcoex.R

# Set the working directory to the scripts directory
WORKDIR /usr/local/src/scripts

# Default command to run when starting the container
CMD ["Rscript", "diffcoex.R", "--help"]
