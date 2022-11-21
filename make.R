#' Practice 3 - Targets
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2022/11/21



## Install Dependencies (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Create subfolders ----

dir.create(here::here("data", "wildfinder"), 
           showWarnings = FALSE, recursive = TRUE)
dir.create(here::here("figures"), 
           showWarnings = FALSE)


## Run Project ----

targets::tar_make()
