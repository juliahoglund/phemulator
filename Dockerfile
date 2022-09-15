FROM rocker/shiny
LABEL authors="Marcin Kierczak"
ARG REPO="nbisweden/phemulator"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get install -y git libxml2-dev libudunits2-dev && \
    rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages(c("shiny","tidyverse","kableExtra"))'

RUN cd /srv/shiny-server/ && \
    git clone https://github.com/${REPO}.git app && \
    sudo chown -R shiny:shiny /srv/shiny-server/app

#COPY . /srv/shiny-server/app/
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app/', host = '127.0.0.1', port = 8787)"]

# docker build -t NBISweden/phemulator:v1.0.0 .
# docker run --rm -p 8787:8787 NBISweden/phemulator:v1.0.0
