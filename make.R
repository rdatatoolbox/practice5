#' Practice 2 - Research Compendium & Rmarkdown
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2022/11/20



## Install Dependencies (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

pkgload::load_all(here::here())


## Run Project ----

rmarkdown::render(here::here("index.Rmd"), 
                  params = list(mammals_family = "Ursidae"))
