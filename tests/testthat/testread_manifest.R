test_that("Extracted filenames are correct", {
  expect_equal(basename(manifest_filelist(
    system.file("extdata", "venuemanifest",
                package = "ReadRedshift")
  )),
  c("venue_csv0000", "venue_csv0001"))
})

test_that("Extracted header names are correct", {
  expect_equal(manifest_headers(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  )$names,
  names(venue))

})

test_that("Manifest number of records is correct", {
  expect_equal(manifest_records(
    system.file("extdata", "venuemanifest", package = "ReadRedshift")
  ),
  nrow(venue))
})
