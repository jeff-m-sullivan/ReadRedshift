#' read_redshift will read in the contents of a manifest and return a data.frame
#'
#' @param manifest_file path to a Redshift manifest file
#'
#' @return the data.frame containing the validated data specified
#' by the manifest file. Delimiters will be detected automatically unless one
#' is specified.
#' @export
#'
#' @examples
#' venue_data <- read_redshift(system.file("extdata","venuemanifest",
#'  package="ReadRedshift"))
read_redshift <- function(manifest_file) {
  data.frame()
}
