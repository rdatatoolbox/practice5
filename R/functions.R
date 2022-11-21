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

read_sp_list <- function(file) {
  
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

read_eco_list <- function(file) {
  
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

read_sp_eco <- function(file) {
  
  suppressMessages(readr::read_csv(file))
}



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

select_species <- function(x, family = NULL) {
  
  if (missing(x)) {
    stop("Argument 'x' is required", call. = FALSE)
  }
  
  if (!is.data.frame(x)) {
    stop("Argument 'x' must be a data.frame", call. = FALSE)
  }
  
  
  ## Filter family(ies) ----
  
  if (!is.null(family)) {
    
    if (!is.character(family) || length(family) != 1) {
      stop("Argument 'family' must be character of length 1", call. = FALSE)
    }
    
    if (!("family" %in% colnames(x))) {
      stop("The column 'family' is absent from 'x'", call. = FALSE)
    }
    
    x <- x |>
      dplyr::filter(.data$family == {{ family }})
  }
  
  
  ## Select columns ----
  
  x |>
    dplyr::select(.data$species_id, .data$sci_name, .data$family)
}



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



#' Save a ggplot2 object
#'
#' @description 
#' This function a [`ggplot2`] object.
#'
#' @param path a character of length 1. The full path of the file name to save.
#' 
#' @param plot a [`ggplot2`] object.
#'
#' @return The full path of the file name
#' 
#' @importFrom ggplot2 ggsave
#' @export

save_plot <- function(path, plot){
  
  ggsave(path, plot)
  path
}
