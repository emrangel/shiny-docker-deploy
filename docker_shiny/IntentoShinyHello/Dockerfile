
# Use a base image with R and Shiny pre-installed
FROM rocker/shiny:latest

# Copy the application directory into the container
COPY app.R /srv/shiny-server/

# Install any additional packages required by the application
RUN R -e "install.packages('shinydashboard')"

# Set the working directory to the application directory
WORKDIR /srv/shiny-server/

# Expose the default port for Shiny apps
EXPOSE 3838

# Start ShinyServer when the container is run
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/', host='0.0.0.0', port=3838)"]

