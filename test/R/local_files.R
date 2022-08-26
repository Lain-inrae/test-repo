#'
NULL

#' @title source_local
#' @description source_local
#' This function sources files given path relative to the main script
#' @param ... a list of R scripts to source.
#' @examples
#' \dontrun{
#'   source_local("my_script.R")
#' }
#' @export source_local
source_local <- function(...) {
  argv <- commandArgs(trailingOnly = FALSE)
  base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
  lapply(file.path(base_dir, c(...)), source)
}
