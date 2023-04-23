FROM eddelbuettel/r2u:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

RUN install.r shiny rmarkdown

# install more packages 
#RUN R -e "install.packages(c('flexdashboard'))"

RUN addgroup --system app && adduser --system --ingroup app app

WORKDIR /home/app

COPY runtime-shiny/ ./

RUN chown app:app -R /home/app

#USER app

EXPOSE 8000

CMD ["R", "-e", "rmarkdown::run(shiny_args = list(port = 8000, host = '0.0.0.0'))"]
