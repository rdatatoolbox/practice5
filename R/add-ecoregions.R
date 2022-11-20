#' Join the three tables of WildFinder
#'
#' @description 
#' This function adds the ecoregions information to the species list by joining
#' the three WildFinder tables.
#'
#' @param x a `tibble` (or `data.frame`). The output of [read_sp_list()].
#' 
#' @param y a `tibble` (or `data.frame`). The output of [read_sp_eco()].
#' 
#' @param z a `tibble` (or `data.frame`). The output of [read_eco_list()].
#'
#' @return A `tibble` with the following two columns: `sci_name` and 
#' `ecoregion`.
#' 
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' \dontrun{
#' ## Download data ----
#' dl_wildfinder_data()
#' 
#' ## Import data ----
#' sp_list  <- read_sp_list(here::here("data", "wildfinder", 
#'                                     "wildfinder-mammals_list.csv"))
#' sp_eco   <- read_sp_eco(here::here("data", "wildfinder", 
#'                                    "wildfinder-ecoregions_species.csv"))
#' eco_list <- read_eco_list(here::here("data", "wildfinder", 
#'                                      "wildfinder-ecoregions_list.csv"))
#'                                    
#' ## Susbet species ----
#' sp_list <- select_species(sp_list, family = "Ursidae")
#' 
#' ## Add ecoregions ----
#' sp_eco_list <- add_ecoregions(sp_list, sp_eco, eco_list)
#' }

add_ecoregions <- function(x, y, z) {
  
  ## Check args ----
  
  if (missing(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }
  
  if (!is.data.frame(x)) {
    stop("Argument 'x' must be a data.frame", call. = FALSE)
  }
  
  if (missing(y)) {
    stop("Argument 'y' is required", call. = FALSE)
  }
  
  if (!is.data.frame(y)) {
    stop("Argument 'y' must be a data.frame", call. = FALSE)
  }
  
  if (missing(z)) {
    stop("Argument 'z' is required", call. = FALSE)
  }
  
  if (!is.data.frame(z)) {
    stop("Argument 'z' must be a data.frame", call. = FALSE)
  }
  
  x |>
    dplyr::left_join(y, by = "species_id") |>
    dplyr::left_join(z, by = "ecoregion_id") |>
    dplyr::select(.data$sci_name, .data$ecoregion)
}
