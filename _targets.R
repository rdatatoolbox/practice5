#' Targets plan
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@fondationbiodiversite.fr}
#' 
#' @date 2022/11/21


## Attach required packages ----

library(targets)
library(tarchetypes)
library(ggplot2)


## Select Mammals family ----

options("mammals_family" = "Ursidae")


## Load Project R Functions ----

source(here::here("R", "functions.R"))


## Analyses pipeline ----

list(
  
  
  ## Download data ----
  
  tar_download(sp_list_path, 
               paste0("https://raw.githubusercontent.com/rdatatoolbox/", 
                      "datarepo/main/data/wildfinder/", 
                      "wildfinder-mammals_list.csv"),
               here::here("data", "wildfinder",
                          "wildfinder-mammals_list.csv")),
  
  tar_download(eco_list_path, 
               paste0("https://raw.githubusercontent.com/rdatatoolbox/", 
                      "datarepo/main/data/wildfinder/", 
                      "wildfinder-ecoregions_list.csv"),
               here::here("data", "wildfinder",
                          "wildfinder-ecoregions_list.csv")),
  
  tar_download(sp_eco_path, 
               paste0("https://raw.githubusercontent.com/rdatatoolbox/", 
                      "datarepo/main/data/wildfinder/", 
                      "wildfinder-ecoregions_species.csv"),
               here::here("data", "wildfinder",
                          "wildfinder-ecoregions_species.csv")),
  
  
  ## Read data ----
  
  tar_target(sp_list, 
             read_sp_list(sp_list_path)),
  
  tar_target(eco_list, 
             read_eco_list(eco_list_path)),
  
  tar_target(sp_eco, 
             read_sp_eco(sp_eco_path)),
  
  
  ## Prepare data ----
  
  tar_target(selected_sp, 
             select_species(sp_list, family = options()$"mammals_family")),
  
  tar_target(selected_sp_w_eco, 
             add_ecoregions(selected_sp, sp_eco, eco_list)),
  
  
  ## Compute outputs ----
  
  tar_target(n_ecoregions_by_sp, 
             count_ecoregions(selected_sp_w_eco)),
  
  tar_target(n_ecoregions_plot, 
             plot_counts(n_ecoregions_by_sp)),
  
  tar_target(n_ecoregions_plot_png,
             save_plot(here::here("figures", "n_ecoregions_plot.png"), 
                       n_ecoregions_plot),
             format = "file"),
  
  
  ## Create report ----
  
  tar_render(report, "index.Rmd", 
             params = list(set_title = options()$"mammals_family"))
)
