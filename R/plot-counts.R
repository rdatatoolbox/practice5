#' Barplot of the number of ecoregions by species
#'
#' @description 
#' This function plots a barplot of the number of distinct ecoregions per 
#' species using the package [`ggplot2`].
#'
#' @param x a `tibble` (or `data.frame`). The output of [count_ecoregions()].
#'
#' @return A `ggplot` object.
#' 
#' @importFrom rlang .data
#' @importFrom ggplot2 ggplot aes geom_bar coord_flip theme_bw labs
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
#' counts_data <- count_ecoregions(sp_eco_list)
#' 
#' ## Plot ----
#' plot_counts(counts_data)
#' }

plot_counts <- function(x) {
  
  ## Check args ----
  
  if (missing(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }
  
  if (!is.data.frame(x)) {
    stop("Argument 'x' must be a data.frame", call. = FALSE)
  }
  
  ggplot(data = x, aes(x = stats::reorder(.data$sci_name, .data$n_ecoregions), 
                       y = .data$n_ecoregions)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    theme_bw() +
    labs(y = "Number of distinct ecoregions", x = "")
}
