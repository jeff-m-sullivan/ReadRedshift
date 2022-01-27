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

