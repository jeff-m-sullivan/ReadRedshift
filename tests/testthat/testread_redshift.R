test_that(
  "Genereated data dimensions match ground truth", {
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
  expect_equal(sort(names(
                 read_redshift(
                   system.file("extdata", "venuemanifest", package = "ReadRedshift")
                 )
               )),
               sort(names(venue)))
})
