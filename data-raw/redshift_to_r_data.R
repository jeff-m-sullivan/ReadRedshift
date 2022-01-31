# Mappings from RedShift datatypes to R

redshift_to_r_data <- list(
  "double precision" = "d",
  "character varying" = "c",
  "date" = "T",
  "integer" = "i"
)

# Mappings from RedShift datatypes to Stata

redshift_to_stata_data <- list(
  "double precision" = "double",
  "character varying" = "str500",
  "date" = "str20",
  "integer" = "long"
)

usethis::use_data(redshift_to_stata_data, redshift_to_r_data, overwrite = TRUE, internal = TRUE)
