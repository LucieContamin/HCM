#' HCM: Puts PSO's data sets in a adapted format to analyse data easily. (Treats only page 9-11 for the moment)
#'
#' It's a data package which has 3 datasets from PSO that have been put in a tidyr format, with normal encoding
#'
#' @section hcm functions:
#' The hcm functions ...
#' @section How were the data sets modified ? :
#'-Data sets have been extracted from the pdf file using tabulizer's extract_table function
#'
#'-Redundant lines such as total..., urban...,rural... have been removed
#'
#'-Titles of the data sets have been changed (a column with district and the other
#'ones with the years)
#'
#'-Years and average populations values have been gathered into columns using tidyr's gather function
#'
#'-All unicodes have been removed and put in dictionary's structure using dictionary's translate function
#'function (not on CRAN, you can find it in : \url{https://github.com/choisy/dictionary} and download it by typing
#'\code{devtools::install_github(choisy/dictionary)}
#'
#'-All values have been converted into relevant classes
#' @docType package
#' @name HCM
NULL
