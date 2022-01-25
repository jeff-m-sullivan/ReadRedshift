#' readRedshift will read in the contents of a manifest and return a data.frame
#'
#' @param manifest_file path to a RedShift manifest file
#'
#' @return the data.frame containing the validated data specified
#' by the manifest file. Delimiters will be detected automatically unless one
#' is specified.
#' @export
#'
#' @examples
#' venue_data <- readRedshift(system.file("extdata","venuemanifest", package="ReadRedshift"))
readRedshift <- function(manifest_file) {
  data.frame()
}
