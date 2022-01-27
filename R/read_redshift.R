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

  col_spec <- paste(create_col_spec(types), sep = "", collapse = "")
  data <- lapply(files,
                 readr::read_delim,
                 col_names = headers,
                 col_types = col_spec)
  d <- do.call(rbind, data)
  stopifnot(n_records == nrow(d))
  return(d)
}

create_col_spec <- function(t, conversion = redshift_to_r_data) {
  stopifnot(all(t %in% names(conversion)))
  conversion[t]
}


#' Create a Stata infile script
#'
#' @param manifest the manifest to be processed
#'
#' @return nothing; file is written directly
#' @export
#'
genereate_stata_infile <- function(manifest_file) {
  files <- manifest_filelist(manifest_file)
  headers <- manifest_headers(manifest_file)$names
  types <- manifest_headers(manifest_file)$types

  t <- create_col_spec(types, conversion = redshift_to_stata_data)
  varlist <- paste(t, headers, collapse = " ")

  outf <- file(paste(basename(manifest_file), ".do", sep = ""))
  writeLines(sapply(
    files,
    FUN = function(f, v)
      c(paste("infile",
            v,
            "using"
            , basename(f),
            ", clear",
            sep = " "),
        "compress",
        paste("save", f, ", replace", sep = " ")
      ),
    v = varlist
  ), outf)
  close(outf)
}
