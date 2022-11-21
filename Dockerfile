## Based on the image RStudio with R 4.2.2 ----

FROM rocker/rstudio:4.2.2

MAINTAINER Nicolas Casajus <nicolas.casajus@fondationbiodiversite.fr>


## Install system dependencies ----

RUN sudo apt update -yq \
 && sudo apt install --no-install-recommends libxml2-dev -yq \
 && sudo apt clean all \
 && sudo apt purge \
 && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## Copy local project ----

ENV folder="/home/rstudio/"

COPY . $folder
RUN chown -R rstudio:rstudio $folder


## Set working directory ----

WORKDIR $folder


## Install R packages ----

ENV RENV_VERSION 0.16.0

RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
 && R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')" \
 && sudo -u rstudio R -e "renv::restore()"
