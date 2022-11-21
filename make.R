#' Practice 5 - Docker
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2022/11/21


## Create subfolders ----

dir.create(here::here("data", "wildfinder"), 
           showWarnings = FALSE, recursive = TRUE)
dir.create(here::here("figures"), 
           showWarnings = FALSE)


## Run Project ----

targets::tar_make()
