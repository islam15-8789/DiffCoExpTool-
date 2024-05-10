# Use an R base image with version 4.0.5 from Rocker
FROM --platform=linux/amd64 rocker/r-ver:4.0.5

# Install necessary Linux dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev && \
    apt-get clean

# Copy the dependencies installation script into the container
COPY install_dependencies.R /usr/local/src/scripts/install_dependencies.R

# Run the install dependencies script
RUN Rscript /usr/local/src/scripts/install_dependencies.R

# Copy the R script into the container
COPY dgca.R /usr/local/src/scripts/dgca.R

# Make the R script executable
RUN chmod +x /usr/local/src/scripts/dgca.R

# Set the working directory to the scripts directory
WORKDIR /usr/local/src/scripts

# Set entrypoint to Rscript
ENTRYPOINT ["Rscript", "dgca.R"]
