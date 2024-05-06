# Use an official R base image
FROM r-base:latest

# Set the maintainer label
LABEL maintainer="yourname@example.com"

# Install Linux dependencies if any are needed (uncomment if needed)
# RUN apt-get update && apt-get install -y \
#    libcurl4-openssl-dev \
#    libssl-dev \
#    libxml2-dev \
#    libudunits2-dev \
#    libgdal-dev \
#    libgeos-dev \
#    libproj-dev

# Install R packages
RUN R -e "install.packages(c('dplyr', 'readr', 'BiocManager', 'optparse', 'DGCA'), dependencies=TRUE)"
# RUN R -e "BiocManager::install('DGCA')"

# Copy the R script into the container
COPY diffcoex.R /usr/local/src/scripts/diffcoex.R

# Make the R script executable
RUN chmod +x /usr/local/src/scripts/diffcoex.R

# Set the working directory to the scripts directory
WORKDIR /usr/local/src/scripts

# Default command to run when starting the container
CMD ["Rscript", "diffcoex.R", "--help"]

