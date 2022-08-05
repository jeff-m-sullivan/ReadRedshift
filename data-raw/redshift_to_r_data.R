# Mappings from RedShift datatypes to R

redshift_to_r_data <- list(
  "double precision" = "d",
  "character varying" = "c",
  "date" = "T",
  "integer" = "i",
  "bigint" = "i",
  "timestamp without time zone" = "T",
  "timestamp" = "T",
  "time without time zone" = "t",
  "time" = "t",
  "date" = "D"
)

# Mappings from RedShift datatypes to Stata

redshift_to_stata_data <- list(
  "double precision" = "double",
  "character varying" = "str500",
  "date" = "str20",
  "integer" = "long",
  "bigint" = "long",
  "timestamp without time zone" = "str20",
  "timestamp" = "str20",
  "time without time zone" = "str20",
  "time" = "str20",
  "date" = "str20"
)

usethis::use_data(redshift_to_stata_data,
  redshift_to_r_data,
  overwrite = TRUE,
  internal = TRUE
)
