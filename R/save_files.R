#' Saving function
#'
#' @description Saving in last month's newly created folder
#'
#' @param file data frame object created using \code{\link{filter_recorded}}
#' @param name_of_file String, suggest to make this the same as the object, will
#' be saved in the last month's folder as a .csv file.
#'
#' @return csv file
#' @export
save_files <- function(file,
                       name_of_file) {
  site_dir <- "data-output/"

  # %m-% months(months_prev)
  file_name <- lubridate::floor_date(Sys.Date(), unit = "month")

  path <- paste0(site_dir, file_name, "/", name_of_file, ".csv")

  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)

  utils::write.csv(file, file = path, row.names = FALSE)
}
