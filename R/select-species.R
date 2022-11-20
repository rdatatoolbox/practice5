#' Select all species of a Mammal family
#'
#' @description 
#' This function selects all the species of a Mammal family (argument `family`).
#' `wildfinder-mammals_list.csv` stored in `data/wildfinder/`.
#'   
#' **Note:** the function [dl_wildfinder_data()] must have been run first.
#'
#' @param x a `tibble` (or `data.frame`). The output of [read_sp_list()].
#' 
#' @param family a `character`. The name of a Mammal family (or several) to 
#'   subset.
#'
#' @return A `tibble` with the following three columns: `species_id`, 
#' `sci_name`, and `family`.
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
#' sp_list <- read_sp_list(here::here("data", "wildfinder", 
#'                                    "wildfinder-mammals_list.csv"))
#'                                    
#' ## Susbet species ----
#' select_species(sp_list, family = "Ursidae")
#' }

select_species <- function(x, family = NULL) {
  
  if (missing(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }
  
  if (!is.data.frame(x)) {
    stop("Argument 'x' must be a data.frame", call. = FALSE)
  }

  
  ## Filter family(ies) ----
  
  if (!is.null(family)) {
    
    if (!is.character(family)) {
      stop("Argument 'family' must be character", call. = FALSE)
    }
    
    if (!("family" %in% colnames(x))) {
      stop("The column 'family' is absent from 'x'", call. = FALSE)
    }
    
    x <- x |>
      dplyr::filter(.data$family %in% {{ family }})
  }
  
  
  ## Select columns ----
  
  x |>
    dplyr::select(.data$species_id, .data$sci_name, .data$family)
}
