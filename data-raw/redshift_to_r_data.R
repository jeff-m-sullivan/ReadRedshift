# Mappings from RedShift datatypes to R

redshift_to_r_data <- list(
  "double precision" = "d",
  "character varying" = "c",
  "date" = "T"
)

usethis::use_data(redshift_to_r_data, overwrite = TRUE)
