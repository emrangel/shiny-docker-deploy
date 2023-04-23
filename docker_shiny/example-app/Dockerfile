# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# copy necessary files
COPY renv.lock /srv/shiny-server/

#COPY /example-app/renv.lock ./renv.lock

# app
COPY global.R /srv/shiny-server/
COPY server.R /srv/shiny-server/
COPY ui.R /srv/shiny-server/

# install renv & restore packages
RUN R -e "install.packages(c('shiny', 'shinydashboard', 'haven', 'ggplot2'))"

#Directory 
WORKDIR /srv/shiny-server/

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/', host='0.0.0.0', port=3838)"]
