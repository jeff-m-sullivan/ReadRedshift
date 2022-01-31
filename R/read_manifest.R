#' Return a list of the data files referenced by this manifest
#'
#' @param manifest path to a manifest file collocated with data
#'
#' @return vector of file names
#' @export
#'
manifest_filelist <- function(manifest) {
  j <- jsonlite::read_json(manifest)
  local_path <- dirname(manifest)
  filenames <- lapply(j$entries, function(e) basename(e$url))
  file.path(local_path, filenames)
}

#' Extract the header names for the data
#'
#' @param manifest local path to the manifest file
#'
#' @return vector of header names, in the order in which they appear; vector of
#' column types, in the same order
#' @export
#'
#' @examples
manifest_headers <- function(manifest) {
  j <- jsonlite::read_json(manifest)
  list(
    names = sapply(j$schema$elements, function(e) e$name),
    types = sapply(j$schema$elements, function(e) e$type$base)
  )
}

#' Extract the total number of records according to the manifest
#'
#' @param manifest local path to the manifest file
#'
#' @return integer of the total number of records in the manifest
#' @export
#'
#' @examples
manifest_records <- function(manifest) {
  j <- jsonlite::read_json(manifest)
  j$meta$record_count
}
