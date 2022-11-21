#' Practice 4 - Renv
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2022/11/21



## Install Dependencies (listed in DESCRIPTION) ----

if (!("renv" %in% installed.packages())) {
  install.packages("renv")
}


renv::activate()
renv::restore()


## Create subfolders ----

dir.create(here::here("data", "wildfinder"), 
           showWarnings = FALSE, recursive = TRUE)
dir.create(here::here("figures"), 
           showWarnings = FALSE)


## Run Project ----

targets::tar_make()
