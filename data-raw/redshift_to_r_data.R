# Mappings from RedShift datatypes to R

redshift_to_r_data <- list(
  "double precision" = "d",
  "numeric" = "d",
  "character varying" = "c",
  "integer" = "i",
  "bigint" = "i",
  "smallint" = "i",
  "timestamp without time zone" = "T",
  "timestamp" = "T",
  "time without time zone" = "t",
  "time" = "t",
  "date" = "D"
)

# Mappings from RedShift datatypes to Stata

redshift_to_stata_data <- list(
  "double precision" = "double",
  "numeric" = "d",
  "character varying" = "str500",
  "date" = "str20",
  "integer" = "long",
  "bigint" = "long",
  "smallint" = "short",
  "timestamp without time zone" = "str20",
  "timestamp" = "str20",
  "time without time zone" = "str20",
  "time" = "str20"
)

usethis::use_data(redshift_to_stata_data,
  redshift_to_r_data,
  overwrite = TRUE,
  internal = TRUE
)
