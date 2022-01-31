test_that("Genereated data dimensions match ground truth", {
  expect_equal(nrow(read_redshift(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  )),
  nrow(venue))
  expect_equal(ncol(read_redshift(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  )),
  ncol(venue))
})

test_that("Generated data has proper names", {
  expect_equal(names(read_redshift(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  )),
  names(venue))
})

test_that("Stata file is properly constructed", {
  expect_silent(generate_stata_infile(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  ))
})

test_that("SQL data types rendered properly", {
  expect_equal(redshift_to_sql_data(
    list(base = "double precision")),
    "DOUBLE")
  expect_equal(redshift_to_sql_data(
    list(base = "date")),
    "DATE")
  expect_equal(redshift_to_sql_data(
    list(base = "integer")),
    "INTEGER")
  expect_equal(redshift_to_sql_data(
    list(base = "character varying",
         max_length = 25)),
    "VARCHAR(25)")
})
