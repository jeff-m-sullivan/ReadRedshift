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
#' venue_data <- read_redshift(system.file("extdata", "venuemanifest",
#'   package = "ReadRedshift"
#' ))
read_redshift <- function(manifest_file) {
  files <- manifest_filelist(manifest_file)
  headers <- manifest_headers(manifest_file)$names
  types <- manifest_headers(manifest_file)$types
  n_records <- manifest_records(manifest_file)

  col_spec <- paste(create_col_spec(types), sep = "", collapse = "")
  data <- lapply(files,
    readr::read_delim,
    col_names = headers,
    col_types = col_spec
  )
  d <- do.call(rbind, data)
  stopifnot(n_records == nrow(d))
  return(d)
}

#' Create scripts to add header lines to all files in a manifest
#'
#' @param manifest_file the manifest to be processed
#'
#' @return silent; the script is written directly
#' @export
#'
#' @examples
insert_header <- function(manifest_file) {
  files <- manifest_filelist(manifest_file)
  headers <- manifest_headers(manifest_file)$names
  header_row <- paste(headers, collapse = ",")

  fout <- file(paste0(manifest_file, "_edit.sh"))
  writeLines(
    paste0(
      "sed -i '1s/^/",
      header_row,
      "\\n/' ", files
    ),
    fout
  )
  close(fout)
}

create_col_spec <- function(t, conversion = redshift_to_r_data) {
  stopifnot(all(t %in% names(conversion)))
  conversion[t]
}


#' Create a Stata infile script
#'
#' @param manifest_file the manifest to be processed
#'
#' @return nothing; file is written directly
#' @export
#'
generate_stata_infile <- function(manifest_file) {
  files <- manifest_filelist(manifest_file)
  headers <- manifest_headers(manifest_file)$names
  types <- manifest_headers(manifest_file)$types

  t <- create_col_spec(types, conversion = redshift_to_stata_data)
  varlist <- paste(t, headers, collapse = " ")

  outf <- file(paste(basename(manifest_file), ".do", sep = ""))
  writeLines(sapply(
    files,
    FUN = function(f, v) {
      c(
        paste("infile",
          v,
          "using",
          basename(f),
          ", clear",
          sep = " "
        ),
        "compress",
        paste("save", f, ", replace", sep = " ")
      )
    },
    v = varlist
  ), outf)
  close(outf)
}

#' Internal function to convert data, since SQL is harder to handle
#'
#' @param type_list type list with parameters for single data element
#'
#' @return a string representing this type in SQL format
#'
redshift_to_sql_data <- function(type_list) {
  stopifnot("base" %in% names(type_list))

  # implementing as a switch, since some elements need extra processing
  switch(type_list$base,
    "integer" = "INTEGER",
    "double precision" = "DOUBLE",
    "date" = "DATE",
    "character varying" = paste0("VARCHAR(", type_list$max_length, ")"),
    stop(paste(type_list$base, " is not on the list of alternatives"))
  )
}


#' Generate SQL loading statements from a manifest file. This assumes that the
#' tables need to be created and then the data copied in.
#'
#' @param manifest_file local path to the manifest file
#' @param s3_url the S3 bucket where the manifest will be stored for loading
#'
#' @return nothing; SQL statements written to file
#' @export
#'
#' @examples
generate_sql_load <- function(manifest_file, s3_url) {
  outfile <- file(paste0(manifest_file, ".sql"), open = "wt")
  table_name <- sub("*manifest$", "", basename(manifest_file))
  writeLines(c(paste0("create table if not exists ", table_name, " (")), outfile)

  variables <- jsonlite::read_json(manifest_file)$schema$elements
  varstmts <- sapply(variables, FUN = function(e) paste0(e$name, "\t", redshift_to_sql_data(e$type), ","))
  writeLines(varstmts, outfile)
  writeLines(c(
    ");", "",
    paste0("copy ", table_name),
    paste0("from '", s3_url, "'/", basename(manifest_file)),
    "manifest"
  ), outfile)
  close(outfile)
}
