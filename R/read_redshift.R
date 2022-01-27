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
  files <- manifest_filelist(manifest_file)
  headers <- manifest_headers(manifest_file)$names
  types <- manifest_headers(manifest_file)$types
  n_records <- manifest_records(manifest_file)

  col_spec <- create_col_spec(types)
  data <- lapply(files, readr::read_delim,
                 col_names = headers,
                 col_types = col_spec)
  d <- do.call(rbind, data)
  stopifnot(n_records == nrow(d))
  return(d)
}

create_col_spec <- function(t) {
  stopifnot(all(t %in% names(redshift_to_r_data)))
  paste(redshift_to_r_data[t], sep = "", collapse = "")
}
