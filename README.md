
<!-- README.md is generated from README.Rmd. Please edit that file -->

# :mortar_board: Practice 2 - Rmarkdown <img src="https://raw.githubusercontent.com/rdatatoolbox/course-compendium/main/img/compendium-logo.png"  align="right" style="float:right; height:120px;"/>

<!-- badges: start -->

[![License:
GPL-2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
<!-- badges: end -->

Structure of the research compendium of the practice 2 of the workshop
**Data Toolbox for Reproducible Research in Ecology**
<https://rdatatoolbox.github.io/ex-rmarkdown.html>.

### Content

This repository is structured as follow:

- [`data/`](https://github.com/rdatatoolbox/practice2/tree/master/data):
  contains all raw data required to perform analyses

- [`R/`](https://github.com/rdatatoolbox/practice2/tree/master/R):
  contains R functions developed especially for this project

- [`man/`](https://github.com/rdatatoolbox/practice2/tree/master/man):
  contains help files of R functions

- [`DESCRIPTION`](https://github.com/rdatatoolbox/practice2/tree/master/DESCRIPTION):
  contains project metadata (author, date, dependencies, etc.)

- [`index.Rmd`](https://github.com/rdatatoolbox/practice2/tree/master/index.Rmd):
  contains the entire analysis

- [`make.R`](https://github.com/rdatatoolbox/practice2/tree/master/make.R):
  main R script to run the entire project by rendering the
  [`index.Rmd`](https://github.com/rdatatoolbox/practice2/tree/master/index.Rmd)

### Usage

Clone the repository, open R/RStudio and run:

``` r
source("make.R")
```

### Notes

- All required packages, listed in the `DESCRIPTION` file, will be
  installed (if necessary)
- All required packages and R functions will be loaded
- Some analyses listed in the `make.R` might take time

### How to cite

> Casajus N, Bonnici I, Dray S, Gimenez O, Guéry L, Guilhaumon F,
> Schiettekatte NMD & Siberchicot A (2022) Workshop FRB-CESAB & GdR
> EcoStat: Data Toolbox for Reproducible Research in Computational
> Ecology. Zenodo. <http://doi.org/10.5281/zenodo.4262978>.
