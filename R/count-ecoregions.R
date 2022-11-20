#' Count ecoregions by species
#'
#' @description 
#' This function counts the number of distinct ecoregions per species.
#'
#' @param x a `tibble` (or `data.frame`). The output of [add_ecoregions()].
#'
#' @return A `tibble` with the following two columns: `sci_name` and 
#' `n_ecoregions`.
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
#' 
#' ## Count ecoregions ----
#' count_ecoregions(sp_eco_list)
#' }

count_ecoregions <- function(x) {
  
  ## Check args ----
  
  if (missing(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }
  
  if (!is.data.frame(x)) {
    stop("Argument 'x' must be a data.frame", call. = FALSE)
  }
  
  x |>
    dplyr::group_by(.data$sci_name) |>
    dplyr::summarise(n_ecoregions = dplyr::n_distinct(.data$ecoregion)) |>
    dplyr::arrange(dplyr::desc(.data$n_ecoregions))
}
