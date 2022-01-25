## code to prepare `venue` dataset goes here

venue <- readr::read_csv(file.path("data-raw", "venue.csv"))
usethis::use_data(venue, overwrite = TRUE)
