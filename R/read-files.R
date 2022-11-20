#' Read species list file - WWF WildFinder
#'
#' @description 
#' This function reads the WWF WildFinder `csv` file named 
#' `wildfinder-mammals_list.csv` stored in `data/wildfinder/`.
#'   
#' **Note:** the function [dl_wildfinder_data()] must have been run first.
#'
#' @param file a character of length 1. The path to the csv file.
#'
#' @return A `tibble` with 4,936 rows (species) and 8 variables describing 
#' species.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' ## Download data ----
#' dl_wildfinder_data()
#' 
#' ## Import data ----
#' sp_list <- read_sp_list(here::here("data", "wildfinder", 
#'                                    "wildfinder-mammals_list.csv"))
#' }

read_sp_list <- function(file) {
  
  ## Check if file exists ----
  
  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist. Please run ", 
         "'dl_wildfinder_data()' to download it.", call. = FALSE)
  }
  
  
  ## Check if file name is good ----
  
  if (basename(file) != "wildfinder-mammals_list.csv") {
    stop("Wrong file name ('wildfinder-mammals_list.csv')", call. = FALSE)
  }
  
  
  ## Open file ----
  
  suppressMessages(readr::read_csv(file))
}



#' Read ecoregions list file - WWF WildFinder
#'
#' @description 
#' This function reads the WWF WildFinder `csv` file named 
#' `wildfinder-ecoregions_list.csv` stored in `data/wildfinder/`.
#'   
#' **Note:** the function [dl_wildfinder_data()] must have been run first.
#'
#' @param file a character of length 1. The path to the csv file.
#'
#' @return A `tibble` with 798 rows (ecoregions) and 4 variables describing 
#' ecoregions.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' ## Download data ----
#' dl_wildfinder_data()
#' 
#' ## Import data ----
#' eco_list <- read_eco_list(here::here("data", "wildfinder", 
#'                                      "wildfinder-ecoregions_list.csv"))
#' }

read_eco_list <- function(file) {
  
  ## Check if file exists ----
  
  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist. Please run ", 
         "'dl_wildfinder_data()' to download it.", call. = FALSE)
  }
  
  
  ## Check if file name is good ----
  
  if (basename(file) != "wildfinder-ecoregions_list.csv") {
    stop("Wrong file name ('wildfinder-ecoregions_list.csv')", call. = FALSE)
  }
  
  
  ## Open file ----
  
  suppressMessages(readr::read_csv(file))
}



#' Read ecoregions-species file - WWF WildFinder
#'
#' @description 
#' This function reads the WWF WildFinder `csv` file named 
#' `wildfinder-ecoregions_species.csv` stored in `data/wildfinder/`.
#'   
#' **Note:** the function [dl_wildfinder_data()] must have been run first.
#'
#' @param file a character of length 1. The path to the csv file.
#'
#' @return A `tibble` with 350,045 rows (ecoregion-species) and 2 variables. 
#' This table is used to merge the two other `tibble`.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' ## Download data ----
#' dl_wildfinder_data()
#' 
#' ## Import data ----
#' sp_eco <- read_sp_eco(here::here("data", "wildfinder", 
#'                                  "wildfinder-ecoregions_species.csv"))
#' }

read_sp_eco <- function(file) {
  
  ## Check if file exists ----
  
  if (!file.exists(file)) {
    stop("The file '", file, "' does not exist. Please run ", 
         "'dl_wildfinder_data()' to download it.", call. = FALSE)
  }
  
  
  ## Check if file name is good ----
  
  if (basename(file) != "wildfinder-ecoregions_species.csv") {
    stop("Wrong file name ('wildfinder-ecoregions_species.csv')", call. = FALSE)
  }
  
  
  ## Open file ----
  
  suppressMessages(readr::read_csv(file))
}
